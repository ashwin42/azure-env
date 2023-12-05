locals {
  providers           = ["azurerm", "netbox"]
  setup_prefix        = "global"
  resource_group_name = "${local.setup_prefix}-rg"
}