resource "azurerm_private_dns_zone" "database" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_a_record" "nv_wuxi_sql_pdz_a" {
  name = "nv-wuxi"
  records = [
    "10.42.0.4",
  ]
  ttl                 = 300
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.database.name
}

resource "azurerm_private_dns_a_record" "nv-siemens-sql" {
  name = "nv-siemens-sql"
  records = [
    "10.44.1.132",
  ]
  ttl                 = 300
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.database.name
}

resource "azurerm_private_dns_a_record" "nv-labx-sql" {
  name = "nv-labx-sql"
  records = [
    "10.44.2.4",
  ]
  ttl                 = 300
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.database.name
}

resource "azurerm_private_dns_a_record" "asrs-nv1-dev-sql" {
  name = "asrs-nv1-dev-sql"
  records = [
    "10.44.5.180",
  ]
  ttl                 = 300
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.database.name
}

resource "azurerm_private_dns_a_record" "nv-e3-sql" {
  name = "nv-e3-sql"
  records = [
    "10.44.5.133",
  ]
  ttl                 = 300
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.database.name
}

resource "azurerm_private_dns_a_record" "asrs-nv1-prod-sql" {
  name = "asrs-nv1-prod-sql"
  records = [
    "10.46.0.4",
  ]
  ttl                 = 300
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.database.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "core_vnet" {
  name                  = "core_vnet"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.database.name
  virtual_network_id    = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/core_network/providers/Microsoft.Network/virtualNetworks/core_vnet"
}

