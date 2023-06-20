#!/usr/bin/env python3
"""
This script generates a markdown file with a list of projects in the repository
based on project.hcl files.

It expects a project.hcl file in each project directory with tags defined, such as:
locals {
  tags = {
    project       = "Moscura"
    jira          = "RD2-727"
    business-unit = "104 R&D AB"
    department    = "104020 R&D Common - AB"
    cost-center   = "104020015 SW & Automation"
    system-owner  = "someone@northvolt.com
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

DELIMITER_START = "<!-- START_PROJECT -->"
DELIMITER_END = "<!-- END_PROJECT -->"
README_FILE = "README.md"
MANDATORY_TAGS = ["business-unit",
                  "department",
                  "cost-center",
                  "jira",
                  "system-owner"]

OPTIONAL_TAGS = ["global-process-owner",
                 "data-owner",
                 "grafana-dashboard",
                 "bcp-link"]


def update_readme(readme_file, project_file, delimiter_start, delimiter_end, new_content):
    """
    Update the README.md file with the new content
    :param readme_file: The README.md file
    :param project_file: The project.md file
    :param delimiter_start: The start delimiter
    :param delimiter_end: The end delimiter
    :param new_content: The new content to be added
    """
    try:
        with open(readme_file, 'r') as file:
            contents = file.read()
    except FileNotFoundError:
        return False

    start_pos = contents.find(delimiter_start)
    end_pos = contents.find(delimiter_end, start_pos + len(delimiter_start))

    if start_pos != -1 and end_pos != -1:
        updated_contents = contents[:start_pos] + delimiter_start + new_content + delimiter_end + contents[end_pos + len(delimiter_end):]
    else:
        updated_contents = contents + delimiter_start + new_content + delimiter_end

    with open(readme_file, 'w') as file:
        file.write(updated_contents)

    with open(project_file, 'w') as file:
        file.write(new_content)

    return True


# List all project.hcl files recursively
project_files = glob.glob(os.path.join(ROOT_DIR, "**/project.hcl"), recursive=True)
all_projects = {}

# Markdown content
markdown_content = "\n## Projects\n"
markdown_content += "This is a list of projects in the repository based on project.hcl files.\n"

# Iterate over each project file
for project_file in project_files:
    os.chdir(ROOT_DIR)

    # Get the project directory
    project_directory = os.path.dirname(project_file)
    os.chdir(project_directory)

    # Load the project.hcl file
    with open("project.hcl") as f:
        try:
            hcl_file = hcl2.load(f)["locals"][0]
        except Exception as e:
            print(f"Skipping on {project_directory} as cannot parse project.hcl: {e}")
            continue

    # check if  project, name or project_name is in
    if "tags" not in hcl_file or "project" not in hcl_file["tags"] or "jira" not in hcl_file["tags"]:
        print(f"Skipping on {project_directory} as no project tag or jira tag in project.hcl")
        continue

    # add terragrunt.hcl and run terragrunt to load project.hcl
    with open("terragrunt.hcl", "w") as f:
        f.write("locals { \n")
        f.write("config = read_terragrunt_config(\"project.hcl\")\n")
        f.write("account = read_terragrunt_config(find_in_parent_folders(\"account.hcl\"))\n")
        f.write("repo_path   = get_path_from_repo_root()\n")
        f.write("}\n")

    try:
        os.system("terragrunt render-json --terragrunt-json-out project.json")
    except Exception as e:
        print(f"Skipping on {project_directory} as terragrunt render-json failed: {e}")
        continue

    # load and parse project.json
    with open("project.json") as f:
        project_json = json.load(f)

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
                                          "resource_group": resource_group})

# Iterate over each project that has the correct tags and create the markdown content
for project in all_projects:
    markdown_content += f"### 🛠️ {project}\n"
    markdown_content += "---\n"
    for project_data in all_projects[project]:
        tags = {}
        for tag in MANDATORY_TAGS:
            if tag not in project_data["tags"]:
                tags[tag] = "❌ **MISSING** (please add to project.hcl)"
            else:
                tags[tag] = project_data["tags"][tag]

        for tag in OPTIONAL_TAGS:
            if tag in project_data["tags"]:
                tags[tag] = project_data["tags"][tag]

        # Add the project information to the markdown content
        markdown_content += f"- Code: [{project_data['repo_path']}]({project_data['repo_path']})\n"
        markdown_content += f"- Jira: [{tags['jira']}]({JIRA_URL}/{tags['jira']})\n"
        markdown_content += "<details><summary>Details (click to expand):</summary>\n"
        markdown_content += "\n"
        markdown_content += "| Detail | Value |\n"
        markdown_content += "| ------ | ----- |\n"

        if project_data["account_type"] == "azure":
            markdown_content += f"| **Azure RG** | {AZURE_PORTAL_URL}/resource/subscriptions/{project_data['account']}/resourceGroups/{project_data['resource_group']} |\n"
        elif project_data["account_type"] == "aws":
            markdown_content += f"| **AWS Account** | {project_data['account']} |\n"

        markdown_content += f"| **Resources** | {project_data['resources']} |\n"
        for key, value in tags.items():
            if key == "project" or key == "jira":
                continue
            markdown_content += f"| **{key}** | {value} |\n"

        markdown_content += "</details>\n\n"
        markdown_content += "---\n"


# Save the markdown content to README.md
os.chdir(ROOT_DIR)
if update_readme('README.md', "PROJECTS.md", DELIMITER_START, DELIMITER_END, markdown_content):
    print(f"{README_FILE} updated")
else:
    print(f"{README_FILE} not updated")
