resource "azurerm_sql_server" "teamcenter" {
  name                         = "${var.application_name}-sqlserver"
  resource_group_name          = "${var.resource_group_name}"
  location                     = "${var.location}"
  version                      = "12.0"
  administrator_login          = "nvadmin"
  administrator_login_password = "${var.database_password}"
}

resource "azurerm_mssql_elasticpool" "teamcenter" {
  name                = "teamcenter-epool"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  server_name         = "${azurerm_sql_server.teamcenter.name}"

  sku {
    name     = "GP_Gen4"
    capacity = 4
    tier     = "GeneralPurpose"
    family   = "Gen4"
  }

  per_database_settings {
    min_capacity = 1
    max_capacity = 4
  }
}

resource "azurerm_sql_database" "teamcenter" {
  name                = "${var.application_name}-database"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  server_name         = "${azurerm_sql_server.teamcenter.name}"
  elastic_pool_name   = "${azurerm_mssql_elasticpool.teamcenter.name}"
  #max_size_bytes      = "1000000000000"

  tags {
    stage = "${var.stage}"
  }
}

resource "azurerm_sql_virtual_network_rule" "teamcenter" {
  name                = "${var.application_name}-sql-vnet-rule"
  resource_group_name = "${var.resource_group_name}"
  server_name         = "${azurerm_sql_server.teamcenter.name}"
  subnet_id           = "${var.subnet_id}"
}

resource "azurerm_sql_firewall_rule" "teamcenter" {
  count               = "${var.teamcenter_server_count}"
  name                = "${var.application_name}${count.index}-sql_firewall_rule"
  resource_group_name = "${var.resource_group_name}"
  server_name         = "${azurerm_sql_server.teamcenter.name}"
  start_ip_address    = "${azurerm_network_interface.teamcenter_network_interface.*.private_ip_address[count.index]}"
  end_ip_address      = "${azurerm_network_interface.teamcenter_network_interface.*.private_ip_address[count.index]}"
}
