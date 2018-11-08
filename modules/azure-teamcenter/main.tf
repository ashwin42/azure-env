resource "azurerm_storage_container" "teamcenter_resources" {
  name                  = "${var.application_name}-resources"
  resource_group_name   = "${var.resource_group_name}"
  storage_account_name  = "${var.storage_account_name}"
  container_access_type = "private"
}
