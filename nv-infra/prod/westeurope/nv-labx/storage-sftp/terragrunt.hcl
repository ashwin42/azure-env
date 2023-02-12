terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.7.32"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/storage"
}

dependency "global" {
  config_path = "../global"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix                    = dependency.global.outputs.setup_prefix
  resource_group_name             = dependency.global.outputs.resource_group.name
  subnet_id                       = dependency.global.outputs.subnet["labx_subnet"].id
  storage_account_name            = "qcsftpstorage"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
  large_file_share_enabled        = true
  min_tls_version                 = "TLS1_0"
  access_tier                     = "Cool"
  identity = {
    type = "SystemAssigned"
  }
  file_shares = [
    {
      name        = "qc-sftp",
      quota       = "102400"
      access_tier = "Cool"
    },
  ]
  private_endpoints = {
    qcsftpstorage-pe-file = {
      subnet_id = dependency.global.outputs.subnet["labx_subnet"].id
      private_service_connection = {
        name              = "qcsftpstorage-pe-file"
        subresource_names = ["file"]
      }
    }
  }

  network_rules = {
    name           = "default_rule"
    bypass         = ["AzureServices"]
    default_action = "Deny"
    virtual_network_subnet_ids     = [dependency.global.outputs.subnet["labx_subnet"].id]
  }
}

