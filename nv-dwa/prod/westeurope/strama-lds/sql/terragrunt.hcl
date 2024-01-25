terraform {
  source = "git@github.com:northvolt/tf-mod-azure.git//mssql?ref=v0.10.13"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//mssql"
}

dependency "subnet" {
  config_path = "../subnet"
}

dependency "resource_group" {
  config_path = "../resource_group"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  name = "dwa-${include.root.locals.all_vars.project}"
}

inputs = {
  resource_group_name           = dependency.resource_group.outputs.resource_group_name
  setup_prefix                  = include.root.locals.all_vars.project
  key_vault_name                = "nvdwainfrasecrets"
  key_vault_rg                  = "global-rg"
  allow_azure_ip_access         = false
  create_administrator_password = true

  private_endpoints = [
    {
      name      = "${include.root.locals.all_vars.project}-sql-pe"
      subnet_id = dependency.subnet.outputs.subnets["${include.root.locals.all_vars.project}-subnet1"].id
      private_service_connection = {
        name              = "${include.root.locals.all_vars.project}-sql-pec"
        subresource_names = ["sqlServer"]
      }
      private_dns_zone_group = {
        dns_zone_resource_group_name = "core_network"
        dns_zone_name                = "privatelink.database.windows.net"
      }
    }
  ]

  lock_resources = false

  azuread_administrator = {
    group = "NV TechOps Role"
  }

  custom_rules = [
    {
      name      = "AllowLocalSubnet"
      subnet_id = dependency.subnet.outputs.subnets["${include.root.locals.all_vars.project}-subnet1"].id
    },
  ]

  databases = [
    {
      name = "Log_DB"
      long_term_retention_policy = {
        weekly_retention = "P8W"
      }
    },
    {
      name = "Results_DB"
      long_term_retention_policy = {
        weekly_retention = "P8W"
      }
    },
    {
      name = "Station_DB"
      long_term_retention_policy = {
        weekly_retention = "P8W"
      }
    },
  ]

  mssql_local_users = [
    {
      username      = "${local.name}-owner"
      roles         = ["db_owner"]
      database      = "Log_DB"
      create_secret = true
    },
    {
      username      = "${local.name}-owner"
      roles         = ["db_owner"]
      database      = "Results_DB"
      create_secret = true
    },
    {
      username      = "${local.name}-owner"
      roles         = ["db_owner"]
      database      = "Station_DB"
      create_secret = true
    },
    {
      username      = "${local.name}-datasystems-reader"
      roles         = ["db_datareader"]
      database      = "Results_DB"
      create_secret = true
    },
    {
      username      = "${local.name}-datasystems-reader"
      roles         = ["db_datareader"]
      database      = "Station_DB"
      create_secret = true
    },
    {
      username      = "${local.name}-reader"
      roles         = ["db_datareader"]
      database      = "Results_DB"
      create_secret = true
    },
    {
      username      = "${local.name}-reader"
      roles         = ["db_datareader"]
      database      = "Station_DB"
      create_secret = true
    },
    {
      username      = "${local.name}-reader"
      roles         = ["db_datareader"]
      database      = "Log_DB"
      create_secret = true
    },
  ]

  custom_rules = [
    {
      name      = "AllowLocalSubnet"
      subnet_id = dependency.subnet.outputs.subnets["strama-lds-subnet1"].id
    }
  ]
}

