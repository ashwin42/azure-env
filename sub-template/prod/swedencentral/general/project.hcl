locals {
  resource_group_name = "${basename(dirname(dirname(dirname(get_terragrunt_dir()))))}-general-rg"
}

