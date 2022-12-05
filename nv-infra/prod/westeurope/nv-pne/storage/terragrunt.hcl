terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.2.21"
  #source = "../../../../../../tf-mod-azure/storage"
}

dependency "global" {
  config_path = "../global"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix             = dependency.global.outputs.setup_prefix
  resource_group_name      = dependency.global.outputs.resource_group.name
  storage_account_name     = "nvpnesa"
  large_file_share_enabled = true
  skuname                  = "Standard_GRS"
  containers_list = [
    { name = "nv-pne-ftp", access_type = "private" }
  ]
  file_shares = [
    { name = "nv-pne-tc6", quota = null },
    { name = "nv-pne-tc7", quota = null },
    { name = "nv-pne-tc9", quota = null },
  ]
  network_rules = [
    {
      name           = "default_rule"
      bypass         = ["AzureServices"]
      default_action = "Deny"
      subnet_ids     = [dependency.global.outputs.subnet["nv-pne-subnet-10.44.5.32"].id]
      ip_rules       = []
    },
  ]
}
