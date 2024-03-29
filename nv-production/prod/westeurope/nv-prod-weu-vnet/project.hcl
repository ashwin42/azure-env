locals {
  setup_prefix        = basename(get_terragrunt_dir())
  resource_group_name = "${local.setup_prefix}-rg"
  tags = {
    business-unit = "109 Digitalization IT - AB"
    department    = "109037 IT Common - AB"
    cost-center   = "109037064 IT Common - AB"
  }
}

