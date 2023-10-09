#!/usr/bin/env python3
"""
This script edits a Confluence page with a list of subscriptions in the repository
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
CONFLUENCE_PAGE_TITLE = "Azure Subscription Inventory"
CONFLUENCE_DELIMITER_START = "Inventory"
CONFLUENCE_DELIMITER_END = "<---! END OF PAGE --->"

SUBSCRIPTION_MANDATORY_TAGS = ["owner"]

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
        end_delimiter = start_header.find_next('h1', string=confluence_delimiter_end)

        if end_delimiter:
            # Remove the content between start_header and the end_delimiter
            while start_header.nextSibling != end_delimiter:
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

# List all /subscription/terragrunt.hcl files recursively
subscription_files = glob.glob(os.path.join(ROOT_DIR, "**/subscription/terragrunt.hcl"), recursive=True)
all_subscriptions = {}

# Subscription markdown content
xhtml_content = """
<table data-table-width=\"1011\" data-layout=\"default\" ac:local-id=\"9b9066eb-ce8a-4698-b0c8-cb2addbd6d4c\">
   <colgroup><col style=\"width: 337.0px;\" /><col style=\"width: 337.0px;\" /><col style=\"width: 337.0px;\" /></colgroup>
   <tbody>
    <tr>
        <th><strong>Name</strong></th>
        <th><strong>Subscription ID</strong></th>
        <th><strong>Owner</strong></th>
    </tr>
"""

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
    xhtml_content += f"""
    <tr>
        <td>{subscription}</td>
"""
    sorted_subscription = sorted(all_subscriptions[subscription], key=lambda f: f["subscription_name"])
    for subscription_data in all_subscriptions[subscription]:
        tags = {}
        for tag in SUBSCRIPTION_MANDATORY_TAGS:
            if tag not in subscription_data["tags"]:
                tags[tag] = "❌ **MISSING**"
            else:
                tags[tag] = subscription_data["tags"][tag]

        # Add the subscription information to the markdown content
        xhtml_content += f"""
        <td>{subscription_data['subscription_id']}</td>
"""
        for key, value in tags.items():
            if key == "subscription":
                continue
            xhtml_content += f"""
        <td>{value}</td>
    </tr>
"""
xhtml_content += """
   </tbody>
</table>
"""

# Save the subscription XHTML content to Confluence page
os.chdir(ROOT_DIR)
if update_confluence_projects(CONFLUENCE_API, CONFLUENCE_SPACE, CONFLUENCE_PAGE_TITLE, CONFLUENCE_DELIMITER_START, CONFLUENCE_DELIMITER_END, xhtml_content):
    print("Confluence page updated")
else:
    print("Confluence page not updated")
