locals {
  project             = basename(get_terragrunt_dir())
  resource_group_name = local.project
  tags = {
    business-unit = "250 Northvolt Battery Systems - BS"
    department    = "250016 Systems Digitalization - BS"
    cost-center   = "250016001 Systems Digitalization - BS"
    jira          = "NDW-580"
    project       = "Dwa - Datasystems"
  }
}
