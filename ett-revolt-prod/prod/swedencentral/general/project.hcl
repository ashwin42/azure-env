locals {
  setup_prefix        = "${basename(dirname(dirname(dirname(get_terragrunt_dir()))))}-${basename(get_terragrunt_dir())}"
  resource_group_name = "${local.setup_prefix}-rg"
}

