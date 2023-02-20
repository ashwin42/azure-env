locals {
  project_name        = basename(get_terragrunt_dir())
  resource_group_name = local.project_name
}
