resource "azurerm_dns_zone" "tia_nvlt_co" {
  name                = "tia.nvlt.co"
  resource_group_name = "${var.resource_group_name}"
  zone_type           = "Public"
}

resource "azurerm_dns_a_record" "vpn_tia" {
  name                = "vpn"
  zone_name           = "${azurerm_dns_zone.tia_nvlt_co.name}"
  resource_group_name = "${var.resource_group_name}"
  ttl                 = 300
  records             = ["${azurerm_public_ip.pritunl.ip_address}"]
}

resource "azurerm_dns_a_record" "hirano_tia" {
  name                = "hirano"
  zone_name           = "${azurerm_dns_zone.tia_nvlt_co.name}"
  resource_group_name = "${var.resource_group_name}"
  ttl                 = 300
  records             = ["${azurerm_network_interface.tia1_network_interface.private_ip_address}"]
}

resource "azurerm_dns_a_record" "zeppelin_tia" {
  name                = "zeppelin"
  zone_name           = "${azurerm_dns_zone.tia_nvlt_co.name}"
  resource_group_name = "${var.resource_group_name}"
  ttl                 = 300
  records             = ["${module.tia_zeppelin.ip_address}"]
}
