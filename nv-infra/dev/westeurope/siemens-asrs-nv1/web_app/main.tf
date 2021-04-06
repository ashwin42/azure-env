resource "azurerm_app_service_plan" "this" {
  name                = "asrs-wcs-dev-asp"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "Windows"
  reserved            = false
  sku {
    tier = "PremiumV2"
    size = "P1v2"
  }
  tags = merge(var.default_tags, var.repo_tag, var.module_tag, var.env_tag, var.tags, {})
}

resource "azurerm_app_service" "this" {
  name                = "asrs-wcs-dev-as"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.this.id
  site_config {
    dotnet_framework_version = "v4.0"
  }
  tags = merge(var.default_tags, var.repo_tag, var.module_tag, var.env_tag, var.tags, {})
}

resource "azurerm_private_endpoint" "this" {
  name                = "asrs-wcs-dev-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "asrs-wcs-dev-pec"
    private_connection_resource_id = azurerm_app_service.this.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "this" {
  app_service_id  = azurerm_app_service.this.id
  subnet_id       = var.subnet_id2
}

