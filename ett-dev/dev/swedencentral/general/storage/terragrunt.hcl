terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.6.10"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//storage"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name                     = include.root.inputs.bootdiag_storage_account_name
  large_file_share_enabled = false
  skuname                  = "Standard_LRS"
  tags = {
    "ms-resource-usage" = "azure-cloud-shell"
  }

  network_rules = {
    name           = "default_rule"
    bypass         = ["AzureServices"]
    default_action = "Allow"
    ip_rules       = []
  }
}