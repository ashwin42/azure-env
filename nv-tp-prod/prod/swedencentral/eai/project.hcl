locals {
  setup_prefix               = basename(get_terragrunt_dir())
  resource_group_name        = "EAI-PROD"
  tags = {
    business-unit = "109 Digitalization IT - AB"
    department    = "109035 Operations & Infrastructure - AB"
    cost-center   = "109035061 Tools & Products"
  }
}

