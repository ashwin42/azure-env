data "azurerm_role_definition" "this" {
  name  = "Contributor"
  scope = "/subscriptions/${var.subscription_id}"
}

resource "azurerm_role_assignment" "this" {
  scope              = azurerm_app_service.this.id
  role_definition_id = data.azurerm_role_definition.this.id
  principal_id       = "c5951bab-97c6-41ba-89e3-0dd2798b5307"
}

