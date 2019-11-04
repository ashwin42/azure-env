// data "azurerm_network_security_group" "AADDS" {
//   name                = "AADDS-northvolt.com-NSG"
//   resource_group_name = azurerm_resource_group.core_network.name}"
// }


// resource "azurerm_subnet_network_security_group_association" "nv_domain_services" {
//   subnet_id                 = local.sn-nv_domain_services
//   network_security_group_id = data.azurerm_network_security_group.AADDS.id
// }