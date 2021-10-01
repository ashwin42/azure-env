resource "azurerm_private_dns_a_record" "asrs-nv1-prod-cathode-as" {
  name = "asrs-nv1-prod-cathode-as"
  records = [
    "10.46.0.5",
  ]
  ttl                 = 300
  resource_group_name = var.resource_group_name
  zone_name           = "privatelink.azurewebsites.net"
}

resource "azurerm_private_dns_a_record" "asrs-nv1-prod-cathode-as_scm" {
  name = "asrs-nv1-prod-cathode-as.scm"
  records = [
    "10.46.0.5",
  ]
  ttl                 = 300
  resource_group_name = var.resource_group_name
  zone_name           = "privatelink.azurewebsites.net"
}

resource "azurerm_private_dns_a_record" "asrs-nv1-prod-anode-as" {
  name = "asrs-nv1-prod-anode-as"
  records = [
    "10.46.0.7",
  ]
  ttl                 = 300
  resource_group_name = var.resource_group_name
  zone_name           = "privatelink.azurewebsites.net"
}

resource "azurerm_private_dns_a_record" "asrs-nv1-prod-anode-as_scm" {
  name = "asrs-nv1-prod-anode-as.scm"
  records = [
    "10.46.0.7",
  ]
  ttl                 = 300
  resource_group_name = var.resource_group_name
  zone_name           = "privatelink.azurewebsites.net"
}

resource "azurerm_private_dns_a_record" "asrs-nv1-prod-cw1-as" {
  name = "asrs-nv1-prod-cw1-as"
  records = [
    "10.46.0.8",
  ]
  ttl                 = 300
  resource_group_name = var.resource_group_name
  zone_name           = "privatelink.azurewebsites.net"
}

resource "azurerm_private_dns_a_record" "asrs-nv1-prod-cw1-as_scm" {
  name = "asrs-nv1-prod-cw1-as.scm"
  records = [
    "10.46.0.8",
  ]
  ttl                 = 300
  resource_group_name = var.resource_group_name
  zone_name           = "privatelink.azurewebsites.net"
}

resource "azurerm_private_dns_a_record" "asrs-nv1-prod-fa1-as" {
  name = "asrs-nv1-prod-fa1-as"
  records = [
    "10.46.0.9",
  ]
  ttl                 = 300
  resource_group_name = var.resource_group_name
  zone_name           = "privatelink.azurewebsites.net"
}

resource "azurerm_private_dns_a_record" "asrs-nv1-prod-fa1-as_scm" {
  name = "asrs-nv1-prod-fa1-as.scm"
  records = [
    "10.46.0.9",
  ]
  ttl                 = 300
  resource_group_name = var.resource_group_name
  zone_name           = "privatelink.azurewebsites.net"
}

resource "azurerm_private_dns_a_record" "asrs-nv1-prod-spw-as" {
  name = "asrs-nv1-prod-spw-as"
  records = [
    "10.46.0.10",
  ]
  ttl                 = 300
  resource_group_name = var.resource_group_name
  zone_name           = "privatelink.azurewebsites.net"
}

resource "azurerm_private_dns_a_record" "asrs-nv1-prod-spw-as_scm" {
  name = "asrs-nv1-prod-spw-as.scm"
  records = [
    "10.46.0.10",
  ]
  ttl                 = 300
  resource_group_name = var.resource_group_name
  zone_name           = "privatelink.azurewebsites.net"
}


