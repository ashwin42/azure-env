data "azurerm_key_vault_secret" "nv-production-core" {
  name         = "nv-wuxi-lead-sql"
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

resource "azurerm_sql_firewall_rule" "ClientIPAddress_2019-9-25_17-8-5" {
  # todo: change resource name
  name                = "ClientIPAddress_2019-9-25_17-8-5"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "31.208.18.58"
  end_ip_address      = "31.208.18.58"
}

resource "azurerm_sql_firewall_rule" "ClientIPAddress_2019-9-26_8-55-57" {
  # todo: change resource name
  name                = "ClientIPAddress_2019-9-26_8-55-57"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "62.20.55.58"
  end_ip_address      = "62.20.55.58"
}

resource "azurerm_sql_firewall_rule" "train" {
  # todo: remove after VPN setup
  name                = "train"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "185.224.57.161"
  end_ip_address      = "185.224.57.161"
}

resource "azurerm_sql_firewall_rule" "wuxi-hotel" {
  # todo: remove after commissioning
  name                = "wuxi-hotel"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "31.208.13.131"
  end_ip_address      = "31.208.13.131"
}

resource "azurerm_sql_firewall_rule" "Wuxi-team" {
  # todo: change resource name
  name                = "Wuxi-team"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "83.233.65.157"
  end_ip_address      = "83.233.65.157"
}

resource "azurerm_sql_firewall_rule" "kyle" {
  # todo: change resource name
  name                = "kyle"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "31.211.219.73"
  end_ip_address      = "31.211.219.73"
}

resource "azurerm_sql_firewall_rule" "kyle-2" {
  # todo: change resource name
  name                = "kyle-2"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "85.30.130.73"
  end_ip_address      = "85.30.130.73"
}

resource "azurerm_sql_firewall_rule" "aws-k8s" {
  name                = "aws-k8s"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "63.33.247.39"
  end_ip_address      = "63.33.247.39"
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

resource "azurerm_sql_firewall_rule" "linnea-home" {
  name                = "linnea-home"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "213.112.195.92"
  end_ip_address      = "213.112.195.92"
}

resource "azurerm_sql_firewall_rule" "kyle-home" {
  name                = "kyle-home"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "188.151.113.108"
  end_ip_address      = "188.151.113.108"
}

resource "azurerm_sql_firewall_rule" "aws-public-ips" {
  # todo: THIS IS TEMPORARY. MUST REMOVE AFTER AWS-AZURE TUNNELING.
  name                = "aws-public-ips"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "99.80.0.0"
  end_ip_address      = "99.81.255.255"
}

resource "azurerm_sql_firewall_rule" "internal-k8s-1" {
  # todo: THIS IS TEMPORARY. MUST REMOVE AFTER AWS-AZURE TUNNELING.
  name                = "internal-k8s-1"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "10.21.13.0"
  end_ip_address      = "10.21.13.255"
}

resource "azurerm_sql_firewall_rule" "internal-k8s-2" {
  # todo: THIS IS TEMPORARY. MUST REMOVE AFTER AWS-AZURE TUNNELING.
  name                = "internal-k8s-2"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "10.21.14.0"
  end_ip_address      = "10.21.14.255"
}

resource "azurerm_sql_firewall_rule" "internal-k8s-3" {
  # todo: THIS IS TEMPORARY. MUST REMOVE AFTER AWS-AZURE TUNNELING.
  name                = "internal-k8s-3"
  resource_group_name = azurerm_resource_group.nv-wuxi-lead.name
  server_name         = azurerm_sql_server.nv-wuxi-lead.name
  start_ip_address    = "10.21.15.0"
  end_ip_address      = "10.21.15.255"
}
