terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//mssql?ref=v0.10.13"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//mssql"
}

dependency "global" {
  config_path = "../global"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name = dependency.global.outputs.resource_group.name
  setup_prefix        = dependency.global.outputs.setup_prefix
  key_vault_name      = "nv-infra-core"
  key_vault_rg        = "nv-infra-core"
  secret_name         = "nv-cmx-sqladmin"

  private_endpoints = [
    {
      name      = "nv-cmx-pe"
      subnet_id = dependency.global.outputs.subnet["nv-cmx-subnet-10.46.0.64-28"].id
      private_service_connection = {
        name              = "nv-cmx-pec"
        subresource_names = ["sqlServer"]
      }
      private_dns_zone_group = {
        dns_zone_name                = "privatelink.database.windows.net"
        dns_zone_resource_group_name = "core_network"
      }
    }
  ]

  lock_resources                = false
  public_network_access_enabled = false

  azuread_administrator = {
    username = "domainjoin@northvolt.com"
  }

  databases = [
    {
      name     = "cmx-ds1"
      edition  = "Standard"
      max_size = "268435456000"
    },
    {
      name     = "cmx-ds2"
      edition  = "Standard"
      max_size = "268435456000"
    },
    {
      name                 = "cmx-labs"
      edition              = "Standard"
      max_size             = "268435456000"
      storage_account_type = "Zone"
    },
    {
      name     = "cmx-revolt"
      edition  = "Standard"
      max_size = "268435456000"
    },
    {
      name     = "cmx-northvolt-systems"
      edition  = "Standard"
      max_size = "268435456000"
    },
    {
      name     = "cmx-nv-ab"
      edition  = "Standard"
      max_size = "268435456000"
    },
    {
      name     = "cmx-us1"
      edition  = "Standard"
      max_size = "268435456000"
    },
    {
      name     = "cmx-fa1"
      edition  = "Standard"
      max_size = "268435456000"
    },
  ]

  custom_rules = [
    {
      name      = "AllowLocalSubnet"
      subnet_id = dependency.global.outputs.subnet["nv-cmx-subnet-10.46.0.64-28"].id
    }
  ]
}
