locals {
  setup_prefix        = basename(get_terragrunt_dir())
  resource_group_name = "${local.setup_prefix}-rg"
  tags = {
    infrastructure-owner = "techops@northvolt.com"
    project = "BI Tomteboda"
    jira    = "TOC-1761"
  }
}
