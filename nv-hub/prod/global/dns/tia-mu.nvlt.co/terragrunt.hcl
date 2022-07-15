terraform {
  source = "./"
}
# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  name                = "tia-mu.nvlt.co"
  resource_group_name = "core_network"
}
