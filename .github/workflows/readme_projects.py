#!/usr/bin/env python3
"""
This script generates a markdown file with a list of projects in the repository based on project.hcl files.
It expects a project.hcl file in each project directory with tags defined, such as:
locals {
  tags = {
    project              = "A project name"
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


ROOT_DIR = os.environ["ROOT_DIR"]
JIRA_URL = os.environ["JIRA_URL"]
AZURE_PORTAL_URL = os.environ["AZURE_PORTAL_URL"]

README_FILE = "README.md"

PROJECT_DELIMITER_START = "<!-- START_PROJECT -->"
PROJECT_DELIMITER_END = "<!-- END_PROJECT -->"
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

def update_readme_projects(
        readme_file,
        project_file,
        project_delimiter_start,
        project_delimiter_end,
        project_new_content,
        ):
    """
    Update the README.md file with the new content
    :param readme_file: The README.md file
    :param project_file: The project.md file
    :param project_delimiter_start: The start delimiter
    :param project_delimiter_end: The end delimiter
    :param project_new_content: The new project content to be added
    """
    try:
        with open(readme_file, 'r') as file:
            contents = file.read()
    except FileNotFoundError:
        contents = ""

    # Update the project information
    project_start_pos = contents.find(project_delimiter_start)
    project_end_pos = contents.find(project_delimiter_end, project_start_pos + len(project_delimiter_start))

    if project_start_pos != -1 and project_end_pos != -1:
        updated_contents = contents[:project_start_pos] + project_delimiter_start + project_new_content + project_delimiter_end + contents[project_end_pos + len(project_delimiter_end):]
    else:
        updated_contents = contents + project_delimiter_start + project_new_content + project_delimiter_end

    # Write the updated contents back to README.md
    with open(readme_file, 'w') as file:
        file.write(updated_contents)

     # Write project information to project.md
    with open(project_file, 'w') as file:
        file.write(project_new_content)

    return True

# List all project.hcl files recursively
project_files = glob.glob(os.path.join(ROOT_DIR, "**/project.hcl"), recursive=True)
all_projects = {}

# Project markdown content
markdown_content = "\n## Projects\n"
markdown_content += "This is a list of projects in the repository based on project.hcl files.\n"

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
        f.write("account = try(read_terragrunt_config(find_in_parent_folders(\"account.hcl\")), \nread_terragrunt_config(\"${get_terragrunt_dir()}/account.hcl\"), {})\n")
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
    maintenance_configurations = None

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

# Iterate over each project that has the correct tags and create the markdown content
for project in sorted(all_projects):
    markdown_content += f"### 🛠️ {project}\n"
    sorted_project = sorted(all_projects[project], key=lambda f: f["repo_path"])
    for project_data in all_projects[project]:
        tags = {}
        for tag in PROJECT_MANDATORY_TAGS:
            if tag not in project_data["tags"]:
                tags[tag] = "❌ **MISSING** (please add to project.hcl)"
            else:
                tags[tag] = project_data["tags"][tag]

        for tag in PROJECT_OPTIONAL_TAGS:
            if tag in project_data["tags"]:
                tags[tag] = project_data["tags"][tag]

        # Add the project information to the markdown content
        markdown_content += f"- Code: [{project_data['repo_path']}]({project_data['repo_path']})\n"
        markdown_content += f"- Jira: [{tags['jira']}]({JIRA_URL}/{tags['jira']})\n"
        markdown_content += "<details><summary>Details (click to expand):</summary>\n"
        markdown_content += "\n"
        markdown_content += "| Detail | Value |\n"
        markdown_content += "| ------ | ----- |\n"

        if project_data["account_type"] == "azure" and project_data["resource_group"] is not None:
            markdown_content += f"| **Azure RG** | {AZURE_PORTAL_URL}/resource/subscriptions/{project_data['account']}/resourceGroups/{project_data['resource_group']} |\n"
        elif project_data["account_type"] == "aws":
            markdown_content += f"| **AWS Account** | {project_data['account']} |\n"

        markdown_content += f"| **Resources** | {project_data['resources']} |\n"
        for key, value in tags.items():
            if key == "project" or key == "jira":
                continue
            markdown_content += f"| **{key}** | {value} |\n"
        
        markdown_content += "| **Patch Orchestration:** | "
        if project_data['maintenance_configurations'] == [{}]:
            markdown_content += "❌ |\n"
        else:
            for config in project_data['maintenance_configurations']:
                for key, value in config.items():
                    markdown_content += f"[{key}]({project_data['repo_path']}): [{value}]({AZURE_PORTAL_URL}/resource/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/patch_management/providers/Microsoft.Maintenance/maintenanceConfigurations/{value}/overview) |\n"
        markdown_content += "</details>\n\n---\n"

# Save the project markdown content to README.md
os.chdir(ROOT_DIR)
if update_readme_projects('README.md', "PROJECTS.md", PROJECT_DELIMITER_START, PROJECT_DELIMITER_END, markdown_content):
    print(f"{README_FILE} updated")
else:
    print(f"{README_FILE} not updated")
