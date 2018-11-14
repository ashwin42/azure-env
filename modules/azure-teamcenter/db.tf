resource "azurerm_sql_server" "teamcenter" {
  name                         = "${var.application_name}-sqlserver"
  resource_group_name          = "${var.resource_group_name}"
  location                     = "${var.location}"
  version                      = "12.0"
  administrator_login          = "nvadmin"
  administrator_login_password = "${var.database_password}"
}

resource "azurerm_sql_database" "teamcenter" {
  name                = "${var.application_name}-database"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  server_name         = "${azurerm_sql_server.teamcenter.name}"

  # edition                          = "General Purpose"
  # requested_service_objective_name = "${var.db_server_size}"

  tags {
    stage = "${var.stage}"
  }
}

resource "azurerm_sql_firewall_rule" "teamcenter" {
  count               = "${var.teamcenter_server_count}"
  name                = "${var.application_name}${count.index}-sql_firewall_rule"
  resource_group_name = "${var.resource_group_name}"
  server_name         = "${azurerm_sql_server.teamcenter.name}"
  start_ip_address    = "${azurerm_network_interface.teamcenter_network_interface.*.private_ip_address[count.index]}"
  end_ip_address      = "${azurerm_network_interface.teamcenter_network_interface.*.private_ip_address[count.index]}"
}
