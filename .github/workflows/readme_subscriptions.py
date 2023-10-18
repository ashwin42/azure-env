#!/usr/bin/env python3
"""
This script generates a markdown file with a list of subscriptions in the repository
based on */subscription/terragrunt.hcl files.

It expects a terragrunt.hcl file in each subscription directory with tags defined, such as:
  tags = {
    owner         = "techops@northvolt.com"
  }
"""

import os
import glob
import json
import hcl2


ROOT_DIR = os.environ["ROOT_DIR"]
JIRA_URL = os.environ["JIRA_URL"]
AZURE_PORTAL_URL = os.environ["AZURE_PORTAL_URL"]

README_FILE = "README.md"

SUBSCRIPTION_DELIMITER_START = "<!-- START_SUBSCRIPTION -->"
SUBSCRIPTION_DELIMITER_END = "<!-- END_SUBSCRIPTION -->"
SUBSCRIPTION_MANDATORY_TAGS = ["owner"]

def update_readme_subscriptions(
        readme_file,
        subscription_file,
        subscription_delimiter_start,
        subscription_delimiter_end,
        subscription_new_content
        ):
    """
    Update the README.md file with the new content
    :param readme_file: The README.md file
    :param subscription_file: The subscription.md file
    :param subscription_delimiter_start: The start delimiter
    :param subscription_delimiter_end: The end delimiter
    :param subscription_new_content: The new subscription content to be added
    """
    try:
        with open(readme_file, 'r') as file:
            contents = file.read()
    except FileNotFoundError:
        contents = ""

    # Update subscription information
    subscription_start_pos = contents.find(subscription_delimiter_start)
    subscription_end_pos = contents.find(subscription_delimiter_end, subscription_start_pos + len(subscription_delimiter_start))

    if subscription_start_pos != -1 and subscription_end_pos != -1:
        updated_contents = contents[:subscription_start_pos] + subscription_delimiter_start + subscription_new_content + subscription_delimiter_end + contents[subscription_end_pos + len(subscription_delimiter_end):]
    else:
        updated_contents = contents + subscription_delimiter_start + subscription_new_content + subscription_delimiter_end

    # Write the updated contents back to README.md
    with open(readme_file, 'w') as file:
        file.write(updated_contents)

    # Write subscription information to subscription.md
    with open(subscription_file, 'w') as file:
        file.write(subscription_new_content)

    return True

# List all /subscription/terragrunt.hcl files recursively
subscription_files = glob.glob(os.path.join(ROOT_DIR, "**/subscription/terragrunt.hcl"), recursive=True)
all_subscriptions = {}

# Subscription markdown content
markdown_content = "\n## Subscriptions\n"
markdown_content += "This is a list of Azure subscriptions in the repository.\n"

# Iterate over each subscription hcl file
for subscription_file in subscription_files:
    os.chdir(ROOT_DIR)

    # Get the subscription directory
    subscription_directory = os.path.dirname(subscription_file)
    os.chdir(subscription_directory)

    # Load the subscription hcl file
    with open("terragrunt.hcl") as f:
        try:
            subscription_hcl_file = hcl2.load(f)
        except Exception as e:
            print(f"Skipping on {subscription_directory} as cannot parse subscription terragrunt.hcl: {e}")
            continue

    try:
        os.system("terragrunt render-json --terragrunt-json-out subscription.json")
    except Exception as e:
        print(f"Skipping on {subscription_directory} as terragrunt render-json failed: {e}")
        continue

    # load and parse subscription.json
    with open("subscription.json") as f:
        subscription_json = json.load(f)

    tags = None
    subscription_name = None
    subscription_id = None

    # get the relevant information from subscription.json
    tags = subscription_json["inputs"]["tags"]
    subscription_name = subscription_json["inputs"]["subscription_name"]
    subscription_id = subscription_json["inputs"]["azurerm_subscription_id"]

    # cleanup subscription.json
    os.remove("subscription.json")

    # Get the relevant information from the parsed HCL
    subscription = {}
    subscription["name"] = subscription_name

    if subscription["name"] not in all_subscriptions:
        all_subscriptions[subscription["name"]] = []

    all_subscriptions[subscription["name"]].append({"subscription_name": subscription_name,
                                          "tags": tags,
                                          "subscription_id": subscription_id})

# Iterate over each subscription that has the correct tags and create the markdown content
for subscription in sorted(all_subscriptions):
    markdown_content += f"### 🔑 {subscription}\n"
    sorted_subscription = sorted(all_subscriptions[subscription], key=lambda f: f["subscription_name"])
    for subscription_data in all_subscriptions[subscription]:
        tags = {}
        for tag in SUBSCRIPTION_MANDATORY_TAGS:
            if tag not in subscription_data["tags"]:
                tags[tag] = "❌ **MISSING**"
            else:
                tags[tag] = subscription_data["tags"][tag]

        # Add the subscription information to the markdown content
        markdown_content += f"- ID: {subscription_data['subscription_id']}\n"
        for key, value in tags.items():
            if key == "subscription":
                continue
            markdown_content += f"- {key}: {value}\n"
        markdown_content += "---\n"

# Save the subscription markdown content to README.md
os.chdir(ROOT_DIR)
if update_readme_subscriptions('README.md', "SUBSCRIPTIONS.md", SUBSCRIPTION_DELIMITER_START, SUBSCRIPTION_DELIMITER_END, markdown_content):
    print(f"{README_FILE} updated")
else:
    print(f"{README_FILE} not updated")
