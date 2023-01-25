resource "azurerm_automation_account" "this" {
  name                = "nv-hub-automation"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = "Basic"
  identity {
    type = "SystemAssigned"
  }
  tags = merge(var.default_tags, var.repo_tag, var.env_tag, var.tags, {})

}

