terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.2.16"
}

dependency "global" {
  config_path = "../global"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix                   = dependency.global.outputs.setup_prefix
  resource_group_name            = dependency.global.outputs.resource_group.name
  subnet_id                      = dependency.global.outputs.subnet["revolt-wave4-subnet-10.44.5.144-28"].id
  storage_account_name           = "revoltwave4sa"
  create_private_endpoints_names = ["blob"]
  containers_list = [
    { name = "revolt-wave4-ftp", access_type = "private" }
  ]
  network_rules = [
    {
      name           = "default_rule"
      bypass         = ["AzureServices"]
      default_action = "Deny"
      subnet_ids     = [dependency.global.outputs.subnet["revolt-wave4-subnet-10.44.5.144-28"].id]
    },
  ]
}
