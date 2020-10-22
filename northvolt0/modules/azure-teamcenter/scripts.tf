resource "azurerm_storage_blob" "first_run" {
  depends_on             = [azurerm_storage_container.teamcenter_resources]
  name                   = "first_run.ps1"
  resource_group_name    = var.resource_group_name
  storage_account_name   = var.storage_account_name
  storage_container_name = azurerm_storage_container.teamcenter_resources.name
  type                   = "block"
  source                 = "${path.module}/scripts/first_run.ps1"
}

resource "azurerm_storage_blob" "create_teamcenter_prereqs" {
  depends_on             = [azurerm_storage_container.teamcenter_resources]
  name                   = "create_teamcenter_prereqs.ps1"
  resource_group_name    = var.resource_group_name
  storage_account_name   = var.storage_account_name
  storage_container_name = azurerm_storage_container.teamcenter_resources.name
  type                   = "block"
  source                 = "${path.module}/scripts/create_teamcenter_prereqs.ps1"
}

resource "azurerm_storage_blob" "download_and_unzip" {
  depends_on             = [azurerm_storage_container.teamcenter_resources]
  name                   = "download_and_unzip.ps1"
  resource_group_name    = var.resource_group_name
  storage_account_name   = var.storage_account_name
  storage_container_name = azurerm_storage_container.teamcenter_resources.name
  type                   = "block"
  source                 = "${path.module}/scripts/download_and_unzip.ps1"
}

