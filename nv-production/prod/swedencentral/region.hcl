locals {
  location = basename(get_parent_terragrunt_dir())
  tags = {
    region = basename(get_parent_terragrunt_dir())
  }
}

