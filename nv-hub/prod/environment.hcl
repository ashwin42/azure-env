locals {
  environment = basename(get_parent_terragrunt_dir())
  tags = {
    environment = "prod"
  }
}
