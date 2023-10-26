terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//mssql?ref=v0.7.44"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//mssql"
}

dependency "subnet" {
  config_path = "../../../../prod/westeurope/nv-ataccama/subnet"
}

# Include all settings from the root terragrunt.hcl file
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name                          = "nvataccamamasterdatadev"
  key_vault_name                = "nv-infra-core"
  key_vault_rg                  = "nv-infra-core"
  minimum_tls_version           = "1.2"
  create_administrator_password = true
  public_network_access_enabled = true
  secret_name                   = "nv-ataccama-dev-sqladmin"
  lock_resources                = false
  identity = {
    type = "SystemAssigned"
  }

  mssql_local_users = [
    {
      username      = "ataccama_sql_ivalua_user"
      roles         = ["db_owner"]
      database      = "ivaluadev"
      create_secret = true
    },
    {
      username      = "ataccama_sql_masterdata_user"
      roles         = ["db_owner"]
      database      = "masterdatatransfdev"
      create_secret = true
    },
    {
      username      = "BI_user"
      roles         = ["db_datawriter"]
      database      = "masterdatatransfdev"
      create_secret = true
    },
      username      = "ataccama"
      roles         = ["db_owner"]
      database      = "masterdatatransfdev"
      create_secret = true
    },
  ]

  mssql_azuread_users = [
    {
      username = "Ataccama - Datalake Admins Dev"
      roles    = ["dbmanager"]
      database = "master"
    },
    {
      username = "Ataccama - Datalake Admins Dev"
      roles    = ["db_owner"]
      database = "ivaluadev"
    },
    {
      username = "Ataccama - Datalake Admins Dev"
      roles    = ["db_owner"]
      database = "masterdatatransfdev"
    }
  ]

  azuread_administrator = {
    group = "NV TechOps Role"
  }

  databases = [
    {
      name                        = "masterdatatransfdev"
      sku_name                    = "GP_S_Gen5_1"
      min_capacity                = "0.5"
      max_size_gb                 = "50"
      auto_pause_delay_in_minutes = "60"
    },
    {
      name        = "ivaluadev"
      max_size_gb = "50"
    }
  ]

  private_endpoints = {
    nv-ataccama-dev-sql-pe = {
      subnet_id = dependency.subnet.outputs.subnet["nv-ataccama-subnet"].id
      private_service_connection = {
        name              = "nv-ataccama-dev-sql-pec"
        subresource_names = ["sqlServer"]
      }
      private_dns_zone_group = {
        name                         = "nv-ataccama-dev-sql"
        dns_zone_resource_group_name = "core_network"
        dns_zone_name                = "privatelink.database.windows.net"
        dns_zone_subscription_id     = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"

      }
    }
  }
  custom_rules = [
    {
      name      = "AllowLocalSubnet"
      subnet_id = dependency.subnet.outputs.subnet["nv-ataccama-subnet"].id
    }
  ]
}

