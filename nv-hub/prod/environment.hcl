locals {
  environment = basename(get_parent_terragrunt_dir())
  tags = {
    environment = basename(get_parent_terragrunt_dir())
  }
}
