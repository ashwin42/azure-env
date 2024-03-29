locals {
  setup_prefix        = basename(get_terragrunt_dir())
  resource_group_name = "${local.setup_prefix}-rg"
  tags = {
    infrastructure-owner = "techops@northvolt.com"
    business-unit        = "109 Digitalization IT - AB"
    department           = "109037 IT Common - AB"
    cost-center          = "109037064 IT Common - AB"
    project              = "SNE"
    jira                 = "TOC-1460"
  }
}

