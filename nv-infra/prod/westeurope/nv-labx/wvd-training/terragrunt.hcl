terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.2.14"
  #source = "../../../../tf-mod-azure/wvd"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

inputs = {
  resource_group_name  = dependency.global.outputs.resource_group.name
  setup_prefix         = "LIMS-Training-"
  wvd_ws_friendly_name = "LIMS Training Workspace"
  wvd_location         = "westeurope"
}
