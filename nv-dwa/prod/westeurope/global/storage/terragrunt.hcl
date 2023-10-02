terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.6.10"
  #source = "../../../../../../tf-mod-azure/storage"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  resource_group_name      = "global-rg"
  name                     = "nvdwainfrabootdiag"
  large_file_share_enabled = false
  skuname                  = "Standard_LRS"
  location                 = "westeurope"
  tags = {
    "ms-resource-usage" = "azure-cloud-shell"
  }

  network_rules = [
    {
      name           = "default_rule"
      bypass         = ["AzureServices"]
      default_action = "Allow"
      ip_rules       = []
    },
  ]
}
