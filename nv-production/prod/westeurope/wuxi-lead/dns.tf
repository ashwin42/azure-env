resource "azurerm_private_dns_a_record" "nv_wuxi_sql_pdz_a" {
  name = "nv-wuxi"
  records = [
    "10.42.0.4",
  ]
  ttl                 = 300
  resource_group_name = "nv-wuxi-lead"
  zone_name           = "privatelink.database.windows.net"
}

resource "azurerm_private_dns_zone" "nv_wuxi_sql_pdz" {
  name                = "privatelink.database.windows.net"
  resource_group_name = "nv-wuxi-lead"
}

