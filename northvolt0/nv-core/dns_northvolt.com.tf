# resource "azurerm_dns_zone" "nortvolt_com" {
#   name                = "northvolt.com"
#   resource_group_name = "${azurerm_resource_group.nv-core.name}"
#   zone_type           = "Public"
# }
# resource "azurerm_dns_a_record" "northvolt_com" {
#   name                = ""
#   zone_name           = "${azurerm_dns_zone.nortvolt_com.name}"
#   resource_group_name = "${azurerm_resource_group.nv-core.name}"
#   ttl                 = 3600
#   records             = ["35.204.11.13"]
# }
# resource "azurerm_dns_cname_record" "www_northvolt_com" {
#   name                = "www"
#   zone_name           = "${azurerm_dns_zone.nortvolt_com.name}"
#   resource_group_name = "${azurerm_resource_group.nv-core.name}"
#   ttl                 = 3600
#   record              = "northvolt.com"
# }

