locals {
  setup_prefix        = basename(get_terragrunt_dir())
  resource_group_name = "${local.setup_prefix}-rg"
  tags = {
    project = "BI Tomteboda"
    jira    = "TOC-1761"
  }
}
