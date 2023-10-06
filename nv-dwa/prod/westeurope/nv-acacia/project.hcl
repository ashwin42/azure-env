locals {
  setup_prefix = basename(get_terragrunt_dir())
  tags = {
    infrastructure-owner = "techops@northvolt.com"
    business-unit        = "Business Unit 309 IT - PL"
    department           = "Department 309067 IT - PL"
    cost-center          = "CostCenter 309067086 IT - PL"
    iaac                 = "false"
    jira                 = "TOC-1625"
    project              = "Acacia"
  }
}

