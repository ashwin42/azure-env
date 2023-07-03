locals {
  project             = basename(get_terragrunt_dir())
  resource_group_name = local.project
  tags = {
#    business-unit = ""
#    department    = ""
#    cost-center   = ""
    jira          = "NDW-580"
    project       = "Dwa - Datasystems"
  }
}
