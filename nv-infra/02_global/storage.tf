resource "azurerm_storage_account" "nvinfrabootdiag" {
  name                      = "nvinfrabootdiag"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_replication_type  = "LRS"
  account_tier              = "Standard"
  account_kind              = "Storage"
  enable_https_traffic_only = false
  tags                      = merge(var.default_tags, { "ms-resource-usage" = "azure-cloud-shell" })
}
