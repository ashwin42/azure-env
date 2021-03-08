resource "azurerm_template_deployment" "nv_sipass_client" {
  name                = "nv_sipass_client"
  resource_group_name = var.resource_group_name

  template_body   = file("template.json")
  parameters_body = file("parameters.json")

  deployment_mode = "Incremental"

}
