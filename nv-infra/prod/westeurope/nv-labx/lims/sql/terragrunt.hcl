terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//mssql?ref=v0.7.18"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//mssql"
}

# Include all settings from the root terragrunt.hcl file
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../../vnet"
}

inputs = {
  setup_prefix   = "nv-labx"
  key_vault_name = "nv-infra-core"
  key_vault_rg   = "nv-infra-core"
  private_endpoints = {
    "nv-labx-pe" = {
      subnet_id = dependency.vnet.outputs.subnets.labx_subnet.id
      private_service_connection = {
        name              = "nv-labx-pec"
        subresource_names = ["sqlServer"]
      }
      create_dns_record            = true
      dns_zone_name                = "privatelink.database.windows.net"
      dns_zone_resource_group_name = "core_network"
      dns_record_name              = "nv-labx-sql"
      dns_zone_subscription_id     = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
      dns_record_ttl               = 300
    }
  }
  minimum_tls_version = "Disabled"
  azuread_administrator = {
    username = "domainjoin@northvolt.com"
  }
  databases = [
    {
      name = "Labware-Test"
    },
    {
      name = "Labware-Prod"
    },
    {
      name = "Labware-Dev"
    },
  ]
  custom_rules = [
    {
      name      = "AllowLocalSubnet"
      subnet_id = dependency.vnet.outputs.subnets.labx_subnet.id
    }
  ]
}
