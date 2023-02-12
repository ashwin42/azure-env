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
  #subnet_id                       = dependency.global.outputs.subnet["labx_subnet"].id
  storage_account_name            = "qcsftpstorage"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
  large_file_share_enabled        = true
  min_tls_version                 = "TLS1_0"
  access_tier                     = "Cool"
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
      /*private_dns_zone_group = {
        name                         = "qcsftpstorage.d923f236-f279-4344-88ad-1f7335ab965f"
        dns_zone_resource_group_name = "nv_infra"
        dns_zone_name                = "privatelink.file.core.windows.net"
        dns_zone_subscription_id     = "11dd160f-0e01-4b4d-a7a0-59407e357777"
      }*/
    }
  }

  network_rules = {
    name           = "default_rule"
    bypass         = ["AzureServices"]
    default_action = "Deny"
    subnet_ids     = dependency.global.outputs.subnet["labx_subnet"].id
  }
}

