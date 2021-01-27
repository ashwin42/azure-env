terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//private_dns?ref=v0.2.4"
}

dependency "global" {
  config_path = "../../vnet"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name = dependency.global.outputs.resource_group.name
  location            = dependency.global.outputs.resource_group.location
  zones               = ["privatelink.file.core.windows.net"]
}
