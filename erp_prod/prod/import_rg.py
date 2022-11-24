#!/usr/bin/env python3
'''
This script imports all resource groups and iam permission from a region
and creates the terraform structure for each resource group and their
iam permissions
'''

from azure.identity import AzureCliCredential
from azure.mgmt.resource import ResourceManagementClient
from azure.cli.core import get_default_cli
from pathlib import Path
import subprocess
from os import chdir

# Variables to update in this block
# ---------------------------------------------
REGION          = "northeurope"
SUBSCRIPTION_ID = "810a32ab-57c8-430a-a3ba-83c5ad49e012"
SUBSCRIPTION    = "erp_prod"
IMPORT          = False # Set to True to auto-import resources
FORCE           = False # Set to True to re-create the existing terragrunt.hcl
chdir(REGION)            # Run the code in this directory
# ---------------------------------------------

# Acquire a credential object using CLI-based authentication.
credential = AzureCliCredential()

# Retrieve the list of resource groups
resource_client = ResourceManagementClient(credential, SUBSCRIPTION_ID)
group_list = resource_client.resource_groups.list()

# Obtain all resource groups
rgs = []
for group in list(group_list):
    if group.location == REGION:
        rgs.append(group.name)


def az_cli(args_str):
    '''
    small function to run az_cli in python (stolen from stackoverflow)

    '''
    args = args_str.split()
    cli = get_default_cli()
    cli.invoke(args, out_file=open('/dev/null', 'w'))
    if cli.result.result:
        return cli.result.result
    elif cli.result.error:
        raise cli.result.error
    return True


for rg in rgs:
    print(f"Updating resource_group: {rg}")
    permissions = az_cli(f'role assignment list --resource-group {rg} --subscription {SUBSCRIPTION}')
    dict_perms = {}
    if permissions is not True:
        for p in permissions:
            if not p["roleDefinitionName"] in dict_perms:
                dict_perms[p["roleDefinitionName"]] = {}

            if not p["principalType"] in dict_perms[p["roleDefinitionName"]]:
                dict_perms[p["roleDefinitionName"]][p["principalType"]] = []

            principal = p["principalName"]
            if principal:

                if p["principalType"] == "ServicePrincipal":
                    principal = az_cli(f'ad sp show --id {principal}')["displayName"]

                dict_perms[p["roleDefinitionName"]][p["principalType"]].append({principal: p["id"]})

    # Don't recreate existing resources
    if Path(f"{rg}/resource_group/terragrunt.hcl").is_file() and not FORCE:
        continue

    Path(f"{rg}/resource_group").mkdir(parents=True, exist_ok=True)

    with open(f"{rg}/resource_group/terragrunt.hcl", "w") as f:
        terragrunt_hcl = r"""terraform {{
          source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.7.15"
        }}

        include {{
          path = find_in_parent_folders()
        }}

        inputs = {{
            resource_group_name = "{resource_group}"
            setup_prefix        = ""
        """.format(resource_group=rg)

        f.write(terragrunt_hcl)

        if dict_perms:
            f.write("iam_assignments     = {\n")
            for role in dict_perms:
                f.write(f"\"{role}\" = {{\n")
                for principal_type in dict_perms[role]:
                    if principal_type == "User":
                        principal_type_fixed = "users"
                    elif principal_type == "Group":
                        principal_type_fixed = "groups"
                    elif principal_type == "ServicePrincipal":
                        principal_type_fixed = "service_principals"
                    else:
                        principal_type_fixed = "UNKNOWN"
                    f.write(f"\"{principal_type_fixed}\" = [\n")
                    for p in dict_perms[role][principal_type]:
                        for principal, resource_id in p.items():
                            f.write(f"\"{principal}\",\n")
                    f.write("],\n")
                f.write("},\n")
            f.write("}\n")
        f.write("}")

    # Run terragrunt import
    if IMPORT:
        subprocess.run(
            ["terragrunt",
             "import",
             "azurerm_resource_group.this",
             f"/subscriptions/{SUBSCRIPTION_ID}/resourceGroups/{rg}"],
            cwd=f"./{rg}/resource_group"
             )
        if dict_perms:
            for role in dict_perms:
                for principal_type in dict_perms[role]:
                    for p in dict_perms[role][principal_type]:
                        for principal, resource_id in p.items():
                            subprocess.run([
                                        "terragrunt",
                                        "import",
                                        f"azurerm_role_assignment.this[\"{role}--{principal}\"]",
                                        resource_id],
                                        cwd=f"./{rg}/resource_group"
                                        )

# Format
subprocess.run(["terragrunt", "hclfmt"])
