data "azurerm_key_vault_secret" "nv-production-core" {
  name         = "nv-wuxi-lead"
  key_vault_id = "${data.azurerm_key_vault.nv-production-core.id}"
}

resource "azurerm_sql_server" "nv-wuxi-lead" {
  name                         = "nv-wuxi"
  resource_group_name          = azurerm_resource_group.nv-wuxi-lead.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "nvwuxi-admin"
  administrator_login_password = "${data.azurerm_key_vault_secret.nv-production-core.value}"
}

resource "azurerm_sql_database" "nv-wuxi-prismatic" {
  name                = "nv-wuxi-prismatic"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  location            = var.location
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  create_mode         = "Default"
  edition             = "GeneralPurpose"
  collation           = "SQL_LATIN1_GENERAL_CP1_CI_AS"
  max_size_bytes      = "1099511627776"
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

resource "azurerm_sql_firewall_rule" "barracks" {
  name                = "barracks"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "155.4.206.91"
  end_ip_address      = "155.4.206.91"
}

resource "azurerm_sql_firewall_rule" "ClientIPAddress_2019-9-25_17-8-5" {
  name                = "ClientIPAddress_2019-9-25_17-8-5"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "31.208.18.58"
  end_ip_address      = "31.208.18.58"
}

resource "azurerm_sql_firewall_rule" "ClientIPAddress_2019-9-26_8-55-57" {
  name                = "ClientIPAddress_2019-9-26_8-55-57"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "62.20.55.58"
  end_ip_address      = "62.20.55.58"
}

resource "azurerm_sql_firewall_rule" "train" {
  name                = "train"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "185.224.57.161"
  end_ip_address      = "185.224.57.161"
}

resource "azurerm_sql_firewall_rule" "wuxi-hotel" {
  name                = "wuxi-hotel"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "31.208.13.131"
  end_ip_address      = "31.208.13.131"
}

resource "azurerm_sql_firewall_rule" "Wuxi-team" {
  name                = "Wuxi-team"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "83.233.65.157"
  end_ip_address      = "83.233.65.157"
}

resource "azurerm_sql_firewall_rule" "kyle" {
  name                = "kyle"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "31.211.219.73"
  end_ip_address      = "31.211.219.73"
}

resource "azurerm_sql_firewall_rule" "kyle-2" {
  name                = "kyle-2"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "85.30.130.73"
  end_ip_address      = "85.30.130.73"
}
