terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.2.19"
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
  subnet_id                      = dependency.global.outputs.subnet.labx_subnet.id
  storage_account_name           = "qcsftpstoragect2"
  skuname                        = "Standard_LRS"
  create_private_endpoints_names = ["file"]
  large_file_share_enabled       = true
  file_shares = [
    { name = "ct2", quota = "81920" },
  ]
  network_rules = [
    {
      name           = "default_rule"
      bypass         = ["AzureServices"]
      default_action = "Allow"
      subnet_ids     = [dependency.global.outputs.subnet.labx_subnet.id]
    },
  ]
}