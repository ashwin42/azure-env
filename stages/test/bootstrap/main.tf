# These are the resources needed to have a remote state setup.
# This needs to be applied before applying any other TF config

# Edit these variables to suit your environment
locals {
  resource_group_name    = "nv-automation-test"
  storage_account_name   = "nvautomationtest"
  storage_container_name = "tfstate"
  location               = "northeurope"
  stage                  = "test"
}

provider "azurerm" {}

# Setup resource group
resource "azurerm_resource_group" "resource_group" {
  name     = "${local.resource_group_name}"
  location = "${local.location}"

  tags {
    stage = "{local.stage}"
  }
}

# Setup storage account
resource "azurerm_storage_account" "storage_account" {
  name                     = "${local.storage_account_name}"
  resource_group_name      = "${azurerm_resource_group.resource_group.name}"
  location                 = "${local.location}"
  account_kind             = "BlobStorage"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags {
    stage = "{local.stage}"
  }
}

# Setup blob storage for statefile

resource "azurerm_storage_container" "storage_container" {
  name                  = "${local.storage_container_name}"
  resource_group_name   = "${azurerm_resource_group.resource_group.name}"
  storage_account_name  = "${azurerm_storage_account.storage_account.name}"
  container_access_type = "private"
}

output "resource_group" {
  value = "${azurerm_resource_group.resource_group.name}"
}
output "storage_account_name" {
  value = "${azurerm_storage_account.storage_account.name}"
}
output "storage_account_id" {
  value = "${azurerm_storage_account.storage_account.id}"
}
output "access_key" {
  value = "${azurerm_storage_account.storage_account.primary_access_key}"
}
output "storage_container" {
  value = "${azurerm_storage_container.storage_container.name}"
}
