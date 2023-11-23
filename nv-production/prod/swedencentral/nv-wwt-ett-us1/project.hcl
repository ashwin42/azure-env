locals {
  netbox_role         = "wwt"
  setup_prefix        = basename(get_terragrunt_dir())
  resource_group_name = "${local.setup_prefix}-rg"
  tags = {
    infrastructure-owner = "techops@northvolt.com"
    project              = "Waste Water Treatment"
    jira                 = "TOC-858"
  }
}

