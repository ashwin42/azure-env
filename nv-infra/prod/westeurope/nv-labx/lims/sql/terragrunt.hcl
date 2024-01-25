terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//mssql?ref=v0.10.13"
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
  secret_name    = "nv-labx-sqladmin"

  private_endpoints = [
    {
      name      = "nv-labx-pe"
      subnet_id = dependency.vnet.outputs.subnets.labx_subnet.id
      private_service_connection = {
        name = "nv-labx-pec"
      }
      private_dns_zone_group = {
        dns_zone_name                = "privatelink.database.windows.net"
        dns_zone_resource_group_name = "core_network"
      }
    },
  ]

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
