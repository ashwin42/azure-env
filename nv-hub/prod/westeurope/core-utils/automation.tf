resource "azurerm_automation_account" "nv-hub-automation" {
  name                = "nv-hub-automation"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = "Basic"

}

