resource "azurerm_private_dns_a_record" "qcsftpstorage" {
  name = "qcsftpstorage"
  records = [
    "10.44.2.5",
  ]
  ttl                 = 300
  resource_group_name = var.resource_group_name
  zone_name           = "privatelink.file.core.windows.net"
}

resource "azurerm_private_dns_a_record" "qcsftpstorage2" {
  name = "qcsftpstoragect2"
  records = [
    "10.44.2.11",
  ]
  ttl                 = 300
  resource_group_name = var.resource_group_name
  zone_name           = "privatelink.file.core.windows.net"
}
