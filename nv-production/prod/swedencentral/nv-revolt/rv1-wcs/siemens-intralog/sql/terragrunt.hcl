terraform {
  source = "git@github.com:northvolt/tf-mod-azure.git//mssql?ref=v0.10.14"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//mssql"
}

dependency "subnet" {
  config_path = "../subnet"
}

dependency "resource_group" {
  config_path = "../resource_group"
}

include "root" {
  path = find_in_parent_folders()
}

locals {
  name   = "rv1-wcs-intralog-db-01"
  subnet = "revolt-wcs-subnet-01"
}

inputs = {
  setup_prefix                  = local.name
  create_administrator_password = true
  key_vault_name                = "nv-production-core"
  key_vault_rg                  = "nv-production-core"
  secret_name                   = "rv1-wcs-intralog-db-01-sqladmin"
  minimum_tls_version           = "1.2"

  private_endpoints = [
    {
      name      = "${local.name}-sql-pe"
      subnet_id = dependency.subnet.outputs.subnets[local.subnet].id
      private_service_connection = {
        name              = "${local.name}-sql-pec"
        subresource_names = ["sqlServer"]
      }
      private_dns_zone_group = {
        dns_zone_resource_group_name = "core_network"
        dns_zone_name                = "privatelink.database.windows.net"
      }
    }
  ]

  lock_resources      = false
  minimum_tls_version = "Disabled"

  azuread_administrator = {
    group = "NV TechOps Role"
  }

  databases = [
    {
      name = "${local.name}"
    },
  ]

  mssql_azuread_users = [
    {
      username = "VPN Siemens ASRS AP"
      roles    = ["db_owner"]
      database = "${local.name}"
    },
    {
      username = "NV TechOps Role"
      roles    = ["db_owner"]
      database = "${local.name}"
    },
  ]

  mssql_local_users = [
    {
      username      = "${local.name}-rw"
      roles         = ["db_owner"]
      database      = "${local.name}"
      create_secret = true
    },
    {
      username      = "${local.name}-ro"
      roles         = ["db_datareader"]
      database      = "${local.name}"
      create_secret = true
    },
  ]

  custom_rules = [
    {
      name      = "AllowLocalSubnet"
      subnet_id = dependency.subnet.outputs.subnets[local.subnet].id
    },
  ]
}

