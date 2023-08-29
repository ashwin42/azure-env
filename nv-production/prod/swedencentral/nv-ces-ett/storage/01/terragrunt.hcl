terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.7.39"
  #source = "../../../../../../tf-mod-azure/storage"
}
dependency "subnet" {
  config_path = "../../subnet"
}

dependency "rv" {
  config_path = "../../recovery_vault"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  setup_prefix = include.root.inputs.setup_prefix
}

inputs = {
  name                         = "${replace("${basename(dirname(dirname(get_terragrunt_dir())))}${basename(get_terragrunt_dir())}stg", "-", "")}"
  register_with_recovery_vault = true
  account_tier                 = "Premium"
  account_replication_type     = "LRS"
  recovery_vault_name          = dependency.rv.outputs.recovery_services.recovery_vault_name
  account_kind                 = "FileStorage"
  file_shares = [
    {
      name           = "cesapp",
      quota          = 127
      lock_resources = false
      access_tier    = "Premium"
      backup_policies = [
        {
          name = "${local.setup_prefix}-share-backup-policy"
          backup = {
            frequency = "Daily"
            time      = "03:00"
          }

          retention_daily = {
            count = 14
          }
          recovery_vault_name = dependency.rv.outputs.recovery_services.recovery_vault_name
        },
      ]
      backup_policy = "${local.setup_prefix}-share-backup-policy"
      iam_assignments = {
        "Storage File Data SMB Share Elevated Contributor" = {
          groups = [
            "NV TechOps Role",
          ],
        },
      }
    },
  ]
  private_endpoints = {
    "${local.setup_prefix}-storage-pe" = {
      subnet_id = dependency.subnet.outputs.subnet["nv-ces-ett-subnet-10.64.1.192_28"].id
      ip_configuration = {
        private_ip_address = "10.64.1.200"
        subresource_name   = "file"
      }
      private_dns_zone_group = {
        name                         = "${local.setup_prefix}-storage-pe-zg"
        dns_zone_name                = "privatelink.file.core.windows.net"
        dns_zone_resource_group_name = "nv_infra"
        dns_zone_subscription_id     = "11dd160f-0e01-4b4d-a7a0-59407e357777"
      }
      private_service_connection = {
        subresource_names = ["file"]
      }
    }
  }
  azure_files_authentication = {
    directory_type = "AADDS"
  }
}
