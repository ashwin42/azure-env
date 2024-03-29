locals {
  setup_prefix        = basename(get_terragrunt_dir())
  resource_group_name = "${local.setup_prefix}-rg"
  key_vault_name      = "nv-production-core"
  key_vault_rg        = "nv-production-core"

  tags = {
    infrastructure-owner = "techops@northvolt.com"
    business-unit        = "104 R&D AB"
    department           = "104020 R&D Common - AB"
    cost-center          = "104020015 SW & Automation"
    jira                 = "RD2-727"
    project              = "Moscura"
  }
}

