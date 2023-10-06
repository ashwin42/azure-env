locals {
  project_name        = basename(get_terragrunt_dir())
  resource_group_name = local.project_name
  tags = {
    infrastructure-owner = "techops@northvolt.com"
    business-unit = "109 Digitalization IT - AB"
    department    = "109035 Operations & Infrastructure - AB"
    cost-center   = "109035060 TechOps"
    system-owner  = "techops@northvolt.com"
  }
}
