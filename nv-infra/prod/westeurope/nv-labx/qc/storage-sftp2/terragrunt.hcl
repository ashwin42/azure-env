terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.7.32"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/storage"
}

dependency "vnet" {
  config_path = "../../vnet"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  setup_prefix                    = "nv-labx"
  storage_account_name            = "qcsftpstorage2"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
  large_file_share_enabled        = true
  access_tier                     = "Cool"
  identity = {
    type = "SystemAssigned"
  }

  file_shares = [
    {
      name        = "qc-sftp2",
      quota       = "102400",
      access_tier = "Cool",
    },
  ]

  private_endpoints = {
    qcsftpstorage2-pe-file = {
      subnet_id = dependency.vnet.outputs.subnets["labx_subnet"].id
      private_service_connection = {
        name              = "qcsftpstorage2-pe-file"
        subresource_names = ["file"]
      }
    }
  }

  network_rules = {
    name                       = "default_rule"
    bypass                     = ["AzureServices"]
    default_action             = "Deny"
    virtual_network_subnet_ids = [dependency.vnet.outputs.subnets["labx_subnet"].id]
    ip_rules = [
      "213.50.54.196",
      "81.233.195.87",
    ]
  }
}

