locals {
  project             = basename(get_terragrunt_dir())
  resource_group_name = local.project
  providers           = ["azurerm", "netbox"]
  tags = {
    infrastructure-owner = "techops@northvolt.com"
    project              = "Strama LDS"
    jira                 = "NDW-334"
  }
}
