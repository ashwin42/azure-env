data "azurerm_key_vault_secret" "nv-production-core" {
  name         = "nv-wuxi-lead-sql"
  key_vault_id = data.azurerm_key_vault.nv-production-core.id
}

resource "azurerm_sql_server" "nv-wuxi-lead" {
  name                         = "nv-wuxi"
  resource_group_name          = azurerm_resource_group.nv-wuxi-lead.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "nvwuxi-admin"
  administrator_login_password = data.azurerm_key_vault_secret.nv-production-core.value
}

resource "azurerm_mssql_server_extended_auditing_policy" "this" {
  server_id                               = azurerm_sql_server.nv-wuxi-lead.id
  storage_endpoint                        = azurerm_storage_account.this.primary_blob_endpoint
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 30
  log_monitoring_enabled                  = false
}

resource "azurerm_sql_database" "nv-wuxi-prismatic" {
  name                = "nv-wuxi-prismatic"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  location            = var.location
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  create_mode         = "Default"
  edition             = "GeneralPurpose"
  collation           = "SQL_LATIN1_GENERAL_CP1_CI_AS"
  max_size_bytes      = "1649267441664"
}

resource "azurerm_sql_database" "nv-wuxi-cylindrical" {
  name                = "nv-wuxi-cylindrical"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  location            = var.location
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  create_mode         = "Default"
  edition             = "GeneralPurpose"
  collation           = "SQL_LATIN1_GENERAL_CP1_CI_AS"
  max_size_bytes      = "1099511627776"
}

resource "azurerm_sql_firewall_rule" "labs-telia" {
  name                = "labs-telia"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "213.50.54.193"
  end_ip_address      = "213.50.54.206"
}

resource "azurerm_sql_firewall_rule" "labs-tele2" {
  name                = "labs-tele2"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "62.20.23.2"
  end_ip_address      = "62.20.23.14"
}

