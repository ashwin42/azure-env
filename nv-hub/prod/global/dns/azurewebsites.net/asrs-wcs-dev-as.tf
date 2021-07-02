resource "azurerm_private_dns_a_record" "siemens_asrs_webapp" {
  name = "asrs-wcs-dev-as"
  records = [
    "10.44.5.182",
  ]
  ttl                 = 300
  resource_group_name = var.resource_group_name
  zone_name           = "privatelink.azurewebsites.net"
}

resource "azurerm_private_dns_a_record" "siemens_asrs_webapp_scm" {
  name = "asrs-wcs-dev-as.scm"
  records = [
    "10.44.5.182",
  ]
  ttl                 = 300
  resource_group_name = var.resource_group_name
  zone_name           = "privatelink.azurewebsites.net"
}
