resource "azurerm_dns_zone" "azure_nvlt_co" {
  name                = "azure.nvlt.co"
  resource_group_name = var.resource_group_name
  tags                = var.default_tags
}
