locals {
  setup_prefix = basename(get_terragrunt_dir())
  providers    = ["mssql"]
}
