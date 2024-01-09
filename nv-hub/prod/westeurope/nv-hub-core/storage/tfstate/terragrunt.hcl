terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.10.7"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//storage"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name                     = "nvhubtfstate"
  large_file_share_enabled = false
  skuname                  = "Standard_LRS"
  account_kind             = "Storage"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_0"

  network_rules = {
    name           = "default_rule"
    bypass         = ["AzureServices"]
    default_action = "Allow"
    ip_rules       = []
  }

  containers = [
    {
      name        = include.root.inputs.remote_state_azurerm_container_name
      access_type = "private"
    },
  ]

  iam_assignments = {
    "Reader and Data Access" = {
      groups = [
        "NV TechOps Read Member",
        "NV TechOps Consultants Member",
      ],
      service_principals = [
        "atlantis-identity"
      ],
    },
  }
}
