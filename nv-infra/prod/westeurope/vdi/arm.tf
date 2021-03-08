resource "azurerm_template_deployment" "nv_vdi_poc_2" {
      name                = "nv_vdi_poc"
      resource_group_name = var.resource_group_name
      
      template_body = file("template.json")
      parameters_body = file("parameters.json")

      deployment_mode = "Incremental"
      
}