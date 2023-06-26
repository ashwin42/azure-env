locals {
  project             = basename(get_terragrunt_dir())
  resource_group_name = local.project
  tags = {
    project = "Strama LDS"
    jira    = "NDW-334"
  }
}
