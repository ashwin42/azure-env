locals {
  setup_prefix        = basename(get_terragrunt_dir())
  resource_group_name = "${local.setup_prefix}-rg"
  key_vault_name      = "nv-production-core"
  key_vault_rg        = "nv-production-core"
  tags = {
    business-unit = "151 Manufacturing Support - LA"
    department    = "151057 Production Management - LA"
    cost-center   = "151057251 Production Management - LA"
    project       = "Congree"
    jira          = "TOC-1716"
  }
}
