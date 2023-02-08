locals {
  setup_prefix        = basename(get_terragrunt_dir())
  resource_group_name = "${basename(get_terragrunt_dir())}-rg"
  tags = {
    business-unit = "109 Digitalization IT - AB"
    department    = "109035 Operations & Infrastructure - AB"
    cost-center   = "109035060 TechOps"
  }
}

