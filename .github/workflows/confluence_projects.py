#!/usr/bin/env python3
"""
This script edits a Confluence page with a list of projects in the repository based on project.hcl files.
It expects a project.hcl file in each project directory with tags defined, such as:
locals {
  tags = {
    project              = "Project Name"
    jira                 = "RD2-123"
    business-unit        = "104 R&D AB"
    department           = "104020 R&D Common - AB"
    cost-center          = "104020015 SW & Automation"
    system-owner         = "someone@northvolt.com
    infrastructure-owner = "techops@northvolt.com"
  }
}
"""

import os
import glob
import json
import hcl2
import subprocess

from atlassian import Confluence
from bs4 import BeautifulSoup

ROOT_DIR = os.environ["ROOT_DIR"]
JIRA_URL = os.environ["JIRA_URL"]
AZURE_PORTAL_URL = os.environ["AZURE_PORTAL_URL"]

CONFLUENCE_API = Confluence(
    url='https://northvolt.atlassian.net',
    username="api-readwrite-techops-confluence@nv-external.com",
    password=os.environ["CONFLUENCE_API_TOKEN"],
    cloud=True)

CONFLUENCE_SPACE = "TO"
CONFLUENCE_PAGE_TITLE = "Inventory of System Deployments"
CONFLUENCE_HEADER_DELIMITER_START = "Azure"
CONFLUENCE_HEADER_DELIMITER_END = "AWS"

PROJECT_MANDATORY_TAGS = ["business-unit",
                  "department",
                  "cost-center",
                  "jira",
                  "system-owner",
                  "global-process-owner",
                  "recovery-time-objective",
                  "data-owner",
                  "infrastructure-owner"]

PROJECT_OPTIONAL_TAGS = ["grafana-dashboard",
                 "bcp-link"]

def virtual_machines(project_directory):
    """
    Parse terragrunt.hcl files for maintenance configurations
    :param project_directory: The project directory
    """
    vm_maintenance_configurations = []

    # List all terragrunt.hcl files recursively
    hcl_files = glob.glob(os.path.join(project_directory, "**/terragrunt.hcl"), recursive=True)

    # Iterate over each terragrunt.hcl file
    for hcl_file in hcl_files:

        # Get the virtual machine name
        vm_name = os.path.basename(os.path.dirname(hcl_file))

        # Load the terragrunt.hcl file
        with open(hcl_file) as f:
            vm_hcl = None

            # Search for the maintenance_configurations block in inputs or locals
            # Add vm_name and maintenance_configuration name to list
            try:
                vm_hcl = hcl2.load(f)["inputs"]["maintenance_configurations"][0]
                for key, value in vm_hcl.items():
                    vm_maintenance_configurations.append((vm_name, value))
                print(f"Maintenance configurations found in {hcl_file}")
            except Exception as e:
                try:
                    vm_hcl = hcl2.load(f)["locals"]["maintenance_configurations"][0]
                    for key, value in vm_hcl.items():
                        vm_maintenance_configurations.append((vm_name, value))
                    print(f"Maintenance configuration found in {hcl_file}")
                except Exception as e:
                    continue
    return vm_maintenance_configurations

def update_confluence_projects(
        confluence_api,
        confluence_space,
        confluence_page_title,
        confluence_delimiter_start,
        confluence_delimiter_end,
        confluence_new_content,
        ):
    """
    Update Confluence page with the new content
    :param confluence_api: Confluence api endpoint & authentication information
    :param confluence_space: Confluence space in which the page exists
    :param confluence_page: The Confluence page title
    :param confluence_delimiter_start: The start delimiter
    :param confluence_delimiter_end: The end delimiter
    :param confluence_new_content: The new project content to be added
    """

    # Get the Confluence page content
    try:
        page_data = confluence_api.get_page_by_title(confluence_space, confluence_page_title, expand='body.storage')
    except Exception as e:
        print("Confluence content could not be retrieved:", e)
        return
    
    # Extract only the body of the Confluence page content
    content = page_data['body']['storage']['value']

    # Parse the Confluence page HTML content
    soup = BeautifulSoup(content, 'html.parser')

    # Find the header that contains the start delimiter
    start_header = soup.find('h1', string=confluence_delimiter_start)

    if start_header:
        # Find the next header that contains the end delimiter after the start header
        next_header = start_header.find_next('h1', string=confluence_delimiter_end)

        if next_header:
            # Remove the content between start_header and next_header
            while start_header.nextSibling != next_header:
                start_header.nextSibling.extract()

            # Create a BeautifulSoup object for your xhtml_content
            xhtml_soup = BeautifulSoup(confluence_new_content, 'html.parser')

            # Insert the xhtml_content right after the start header
            start_header.insert_after(xhtml_soup)

            # Update the page content with the modified HTML
            updated_content = str(soup)
            confluence_api.update_page(
                page_id=page_data['id'],
                title=confluence_page_title,
                body=updated_content,
            )

            return True

    print(f"Could not find the following headers: '{confluence_delimiter_start}' and '{confluence_delimiter_end}'")
    return False


# List all project.hcl files recursively
project_files = glob.glob(os.path.join(ROOT_DIR, "**/project.hcl"), recursive=True)
all_projects = {}

# Project XHTML content
xhtml_content = ""

# Iterate over each project file
for project_file in project_files:
    os.chdir(ROOT_DIR)

    # Get the project directory
    project_directory = os.path.dirname(project_file)
    os.chdir(project_directory)

    # Get the virtual machine maintenance configurations
    vm_maintenance_configurations = virtual_machines(project_directory)

    # Load the project.hcl file
    with open("project.hcl") as f:
        try:
            hcl_file = hcl2.load(f)["locals"][0]
        except Exception as e:
            print(f"Skipping on {project_directory} as cannot parse project.hcl: {e}")
            continue

    # check if project, name or project_name is in
    if "tags" not in hcl_file or "project" not in hcl_file["tags"] or "infrastructure-owner" not in hcl_file["tags"]:
        print(f"Skipping on {project_directory} as no project & infrastructure-owner tags in project.hcl")
        continue

    # add terragrunt.hcl and run terragrunt to load project.hcl
    with open("terragrunt.hcl", "w") as f:
        f.write("locals { \n")
        f.write("config = read_terragrunt_config(\"project.hcl\")\n")
        f.write("account = try(read_terragrunt_config(find_in_parent_folders(\"account.hcl\")), \nread_terragrunt_config(\"${get_terragrunt_dir()/account.hcl}\"), {})\n")
        f.write("repo_path   = get_path_from_repo_root()\n")
        f.write("maintenance_configurations = [\n")
        f.write("   {\n")
        for key, value in vm_maintenance_configurations:
            f.write(f"      {key} = \"{value}\"\n")
        f.write("   }\n]\n")
        f.write("}\n")

    try:
        os.system("terragrunt render-json --terragrunt-json-out project.json")
    except Exception as e:
        print(f"Skipping on {project_directory} as terragrunt render-json failed: {e}")
        continue

    # load and parse project.json
    with open("project.json") as f:
        project_json = json.load(f)

    tags = None
    repo_path = None
    account = None
    account_type = None
    resource_group = None

    # get the relevant information from project.json
    tags = project_json["locals"]["config"]["locals"]["tags"]
    repo_path = project_json["locals"]["repo_path"]
    if "azurerm_subscription_id" in project_json["locals"]["account"]["locals"]:
        account_type = "azure"
        account = project_json["locals"]["account"]["locals"]["azurerm_subscription_id"]
    elif "aws_account_id" in project_json["locals"]["account"]["locals"]:
        account_type = "aws"
        account = project_json["locals"]["account"]["locals"]["aws_account_id"]
    else:
        account_type = "unknown"
        account = "unknown"

    if "resource_group_name" in project_json["locals"]["config"]["locals"]:
        resource_group = project_json["locals"]["config"]["locals"]["resource_group_name"]

    # list all resources in the project with gsource *= *\K.*github\.com.(.*)\"rep
    try:
        resources = subprocess.run(["grep", "-hRoP", r"source *= *.*github\.com.\K.*(?=\")"], stdout=subprocess.PIPE).stdout.decode('utf-8')
        resources = resources.replace("\n", "<br>")
    except Exception as e:
        print(f"Skipping resources as grep failed: {e}")
        resources = "No resources found"

    if "maintenance_configurations" in project_json["locals"]:
         maintenance_configurations = project_json["locals"]["maintenance_configurations"]

    # cleanup terragrunt.hcl and project.json
    os.remove("terragrunt.hcl")
    os.remove("project.json")

    # Get the relevant information from the parsed HCL
    project = {}
    project["name"] = tags["project"]

    if project["name"] not in all_projects:
        all_projects[project["name"]] = []

    all_projects[project["name"]].append({"repo_path": repo_path,
                                          "tags": tags,
                                          "account": account,
                                          "account_type": account_type,
                                          "resources": resources,
                                          "resource_group": resource_group,
                                          "maintenance_configurations": maintenance_configurations})

# Iterate over each project that has the correct tags and create the XHTML content
for project in sorted(all_projects):
    xhtml_content += f"<h2>🛠️ {project}</h2>"
    sorted_project = sorted(all_projects[project], key=lambda f: f["repo_path"])
    for project_data in all_projects[project]:
        tags = {}
        for tag in PROJECT_MANDATORY_TAGS:
            if tag not in project_data["tags"]:
                tags[tag] = "❌ <strong>MISSING</strong>"
            else:
                tags[tag] = project_data["tags"][tag]

        for tag in PROJECT_OPTIONAL_TAGS:
            if tag in project_data["tags"]:
                tags[tag] = project_data["tags"][tag]

        # Add the project information to the XHTML content
        xhtml_content += f"Code: <a href='https://github.com/northvolt/azure-env/tree/master/{project_data['repo_path']}'>{project_data['repo_path']}</a><br />"
        xhtml_content += f"Jira: <a href='{JIRA_URL}/{tags['jira']}'>{tags['jira']}</a>"
        expand_content = f"""
<table>
    <tr>
        <th><strong>Detail</strong></th>
        <th><strong>Value</strong></th>
    </tr>
"""
        if project_data["account_type"] == 'azure' and project_data["resource_group"] is not None:
            expand_content += f"""
    <tr>
        <td>Azure RG</td>
        <td><a href='{AZURE_PORTAL_URL}/resource/subscriptions/{project_data['account']}/resourceGroups/{project_data['resource_group']}'>{project_data['resource_group']}</a></td>
    </tr>
"""
        elif project_data["account_type"] == 'aws':
            expand_content += f"""
    <tr>
        <td>AWS Account</td>
        <td>{project_data['account']}</td>
    </tr>
"""
        for key, value in tags.items():
            if key == 'project' or key == 'jira':
                continue
            expand_content += f"""
    <tr>
        <td>{key}</td>
        <td>{value}</td>
    </tr>
"""
        expand_content += f"""
    <tr>
        <td>patch orchestration:</td>
        <td>"""
        if project_data["maintenance_configurations"] == [{}]:
            expand_content += "❌</td>"
        else:
            for config in project_data['maintenance_configurations']:
                for key, value in config.items(): 
                    expand_content +=f"<a href='https://github.com/northvolt/azure-env/tree/master/{project_data['repo_path']}'>{key}</a>: <a href='{AZURE_PORTAL_URL}/resource/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/patch_management/providers/Microsoft.Maintenance/maintenanceConfigurations/{value}/overview'>{value}</a></td>"
        expand_content += f"""
    </tr>
</table>
"""
        xhtml_content += f"""
<ac:structured-macro ac:name="expand">
    <ac:parameter ac:name="title">Details (click to expand)</ac:parameter>
    <ac:rich-text-body>
        <p>{expand_content}</p>
    </ac:rich-text-body>
</ac:structured-macro>
<hr />
"""

# Save the project XHTML content to Confluence page
os.chdir(ROOT_DIR)
if update_confluence_projects(CONFLUENCE_API, CONFLUENCE_SPACE, CONFLUENCE_PAGE_TITLE, CONFLUENCE_HEADER_DELIMITER_START, CONFLUENCE_HEADER_DELIMITER_END, xhtml_content):
    print("Confluence page updated")
else:
    print("Confluence page not updated")
