# Azure Subscription Template

[![Terraform Module](https://img.shields.io/badge/module-tf--mod--azure-5c4ee0.svg)](https://github.com/northvolt/tf-mod-azure/tree/master/subscription)

This template is used on to how configure and setup your azure subscription.

## Step 1: Subscription Deployment

Follow this step-by-step guide below to deploy your azure subscription:

#### IMPORTANT: When renaming sub-template to your new subscription that includes spaces, always include "-" and NOT "_" for name spacing
#### For more informationg regarding "Azure Naming Restriction" click [here](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules)

* Copy the `sub-template` and paste it locally in your cloned azure-env repo
* Remove the copied README.md file (this file but in your copied template)
* Rename the subscription_directory folder for your new subscription name
* Create a `local.hcl` file under the subscription dir with the following content:

```bash
locals {
  # On first run, next two lines are uncommented, after tfstate storage is set, they should be commented
  local_state_enabled          = true
  remote_state_azurerm_enabled = false
} 
```

* Set the desired Management Group in `subscription/terragrunt.hcl`
 * Import the Management Group into state (ex to import mgmt group "Managed" below):

 ```bash
 terragrunt import 'azurerm_management_group_subscription_association.this' '/managementGroup/nv_managed/subscription/your-subscription-ID'
 ```

"Double check": When imported run `terragrunt plan` to see if infra matches the config set

* Create an alias for you Subscription with Azure Cloud Shell:
 ```bash
 az account alias create --name "subscription_name" --subscription-id "subscription_id"
 ```

* Run "az login"

## Step 2: Configuration in `account.hcl` and local/remote state 

Here are the variables you need set in the file:

- `azurerm_subscription_id`: The ID of your Azure subscription for the AzureRM provider.
- `subscription_id`: The ID of your Azure subscription.

* Move into tfstate/resource_group and uncomment line 2,3 in `project.hcl` (the lines below):

```bash
locals {
  #local_state_enabled          = true
  #remote_state_azurerm_enabled = false
}
```
* Run `terragrunt apply` in /resource_group and /storage directories

* Move into subscription directory, delete the local.hcl file and run `terragrunt init -migrate-state`
* Delete the local state files (terraform.tfstate) in subscription directory
* Run `terragrunt apply` to confirm that state is uploaded remotely
* Comment line 2,3 in project.hcl under /tfstate/ and run `terragrunt init -state-migrate` in /resource_group/ and /storage/ directories
* Delete the local state file in each of those directories
* Confirm that state is uploaded remotely by running `terragrunt apply`

## Step 3: Optional resources

Based on if you create resources in swedencentral or westeurope, copy the `general` folder to the one that you will mainly build this subscription for and create the following:

* /general/resource_group: run `terragrunt apply`
* /general/vaults/: run `terragrunt apply` in both /encryption and /secrets
* /general/vnet: set appropriate address_space and prefix in `terragrunt.hcl`, check addresses in netbox and run `terragrunt apply`
* /general/storage: run `terragrunt apply`
* /general/recovery_vault: run `terragrunt apply`


