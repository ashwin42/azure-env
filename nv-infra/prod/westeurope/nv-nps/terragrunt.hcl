# Include all settings from the root terragrunt.hcl file
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  resource_group_name = "nv_nps"
}
