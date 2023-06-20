locals {
  setup_prefix = basename(get_terragrunt_dir())
  tags = {
    business-unit = "Business Unit 309 IT - PL"
    department    = "Department 309067 IT - PL"
    cost-center   = "CostCenter 309067086 IT - PL"
    iaac          = "false"
    jira          = "TOC-1625"
    project       = "Acacia"
  }
}

