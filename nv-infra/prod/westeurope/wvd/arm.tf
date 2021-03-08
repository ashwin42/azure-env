resource "azurerm_template_deployment" "nv_wvd_poc" {
  name                = "nv_wvd_poc"
  resource_group_name = var.resource_group_name

  template_body   = file("template.json")
  parameters_body = file("parameters.json")

  deployment_mode = "Incremental"

}