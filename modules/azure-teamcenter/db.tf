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

  tags {
    stage = "${var.stage}"
  }
}
