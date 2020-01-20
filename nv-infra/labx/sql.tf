data "azurerm_key_vault_secret" "nv-labx-sql" {
  name         = "nv-labx-sql"
  key_vault_id = data.azurerm_key_vault.nv-infra-core.id
}

resource "azurerm_sql_server" "nv-labx-sql-server" {
  name                         = "nv-sql-server"
  resource_group_name          = azurerm_resource_group.nv_labx.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "nv-labx-sql"
  administrator_login_password = data.azurerm_key_vault_secret.nv-labx-sql.value
}

resource "azurerm_sql_database" "nv-labx-sql" {
  name                = "nv-labx-sql"
  resource_group_name = azurerm_resource_group.nv_labx.name
  location            = var.location
  server_name         = azurerm_sql_server.nv-labx-sql-server.name
  create_mode         = "Default"
  edition             = "GeneralPurpose"
  collation           = "SQL_LATIN1_GENERAL_CP1_CI_AS"
  max_size_bytes      = "107374182400"
}

resource "azurerm_sql_firewall_rule" "Allow_Inbound" {
  name                = "Allow_Inbound"
  resource_group_name = azurerm_resource_group.nv_labx.name
  server_name         = azurerm_sql_server.nv-labx-sql-server.name
  start_ip_address    = "62.20.55.58"
  end_ip_address      = "62.20.55.58"
}

resource "azurerm_sql_firewall_rule" "Allow_Inbound_pontus" {
  name                = "Allow_Inbound_pontus"
  resource_group_name = azurerm_resource_group.nv_labx.name
  server_name         = azurerm_sql_server.nv-labx-sql-server.name
  start_ip_address    = "83.233.110.151"
  end_ip_address      = "83.233.110.151"
}

resource "azurerm_sql_firewall_rule" "Factory" {
  name                = "Factory"
  resource_group_name = azurerm_resource_group.nv_labx.name
  server_name         = azurerm_sql_server.nv-labx-sql-server.name
  start_ip_address    = "213.50.54.193"
  end_ip_address      = "213.50.54.206"
}
