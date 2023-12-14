# azure-env

This is the infrastructure repository where all Azure cloud-infrastructure is defined and managed using Terraform.


# Contributing
You are welcome to contribute to this repository, see below for instructions how to create a pull request, get it approved and merged.

### Workflow
Use a _fork -> clone -> edit -> pull request_ workflow. See this guide how such a workflow is created:
https://github.com/firstcontributions/first-contributions/blob/master/README.md

### Who approves your pull request?
By default the TechOps team are automatically set as approvers for pull requests in this repository unless an override for specific files or directories within this repo has been defined in the [codeowners](https://github.com/northvolt/azure-env/blob/master/CODEOWNERS) file.

### Who merges your pull request?
Once a pull request is approved, the pull request creator is expected to merge it.

### Applying your changes
Code changes in this repository is currently _**not**_ automatically picked up by a CI service and need to be manually applied. If you don't have the needed permissions to the Azure environment to apply the changes yourself ask someone in the TechOps Team to do it for you.

### Moving terraform state
Moving a terraform state within the same subscription from folder A to folder B, see the following Confluence article: [Moving terragrunt.hcl files](https://northvolt.atlassian.net/wiki/spaces/TO/pages/3339027186/Moving+terragrunt.hcl+files)
