resource "azurerm_private_dns_a_record" "revolt-wave4-blob" {
  name = "revoltwave4sa"
  records = [
    "10.44.5.152",
  ]
  ttl                 = 300
  resource_group_name = var.resource_group_name
  zone_name           = "privatelink.blob.core.windows.net"
}
