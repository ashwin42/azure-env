terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.5.6"
  #source = "../../../../../../tf-mod-azure/storage"
}

/*
dependency "global" {
  config_path = "../global"
}
*/

include {
  path = find_in_parent_folders()
}

inputs = {
  #setup_prefix             = dependency.global.outputs.setup_prefix
  resource_group_name      = "techops-rg"
  storage_account_name     = "nvtechopsstorage"
  large_file_share_enabled = true
  skuname                  = "Standard_LRS"
  location                 = "swedencentral"
  tags = {
    "ms-resource-usage" = "azure-cloud-shell"
  }
  file_shares = [
    {
      name  = "nv-techops-fs",
      quota = 6
    },
  ]

  network_rules = [
    {
      name           = "default_rule"
      bypass         = ["AzureServices"]
      default_action = "Allow"
      ip_rules       = []
    },
  ]
}
