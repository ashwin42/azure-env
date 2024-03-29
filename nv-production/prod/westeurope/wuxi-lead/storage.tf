resource "azurerm_storage_account" "this" {
  name                      = "nvwuxi"
  resource_group_name       = azurerm_resource_group.nv-wuxi-lead.name
  location                  = azurerm_resource_group.nv-wuxi-lead.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  account_kind              = "StorageV2"
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_0"
}
