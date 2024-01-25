terraform {
  source = "git@github.com:northvolt/tf-mod-azure.git//mssql?ref=v0.10.13"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//mssql"
}

dependency "vnet" {
  config_path = "../subnet"
}

dependency "sql_app" {
  config_path = "../sql_app"
}

include "root" {
  path = find_in_parent_folders()
}

locals {
  secret_name = "${basename(dirname(get_terragrunt_dir()))}-${basename(get_terragrunt_dir())}"
}

inputs = {
  key_vault_name        = "nv-production-core"
  key_vault_rg          = "nv-production-core"
  subnet_id             = dependency.vnet.outputs.subnets["nv-lims-subnet-10.64.1.32_27"].id
  lock_resources        = false
  minimum_tls_version   = "Disabled"
  mssql_app_login       = true
  mssql_federated_login = false

  azuread_administrator = {
    group = "Labware LIMS Developers"
  }

  create_administrator_password = true
  secret_name                   = "nv-lims-sqladmin"

  databases = [
    {
      name     = "Labware-Prod"
      sku_name = "GP_Gen5_8"
      long_term_retention_policy = {
        weekly_retention  = "P8W"
        monthly_retention = "P12M"
      }

    },
    {
      name = "Labware-Test"
      long_term_retention_policy = {
        weekly_retention  = "P8W"
        monthly_retention = "P12M"
      }
    },
    {
      name = "Labware-Dev"
      long_term_retention_policy = {
        weekly_retention  = "P8W"
        monthly_retention = "P12M"
      }
    },
  ]

  mssql_user_client_id     = dependency.sql_app.outputs.client_id
  mssql_user_client_secret = dependency.sql_app.outputs.service_principal_password

  mssql_local_users = [
    {
      username    = "nv_rw_user]"
      roles       = ["db_datawriter"]
      database    = "Labware-Prod"
      secret_name = "${local.secret_name}-Labware-Prod-nvrwuser"
    },
    {
      username    = "nv_rw_user]"
      roles       = ["db_datawriter"]
      database    = "Labware-Test"
      secret_name = "${local.secret_name}-Labware-Test-nvrwuser"
    },
    {
      username    = "nv_rw_user]"
      roles       = ["db_datawriter"]
      database    = "Labware-Dev"
      secret_name = "${local.secret_name}-Labware-Dev-nvrwuser"
    },
    {
      username    = "nv_ro_user"
      roles       = ["db_datareader"]
      database    = "Labware-Prod"
      secret_name = "${local.secret_name}-Labware-Prod-nvrouser"
    },
    {
      username    = "nv_ro_user"
      roles       = ["db_datareader"]
      database    = "Labware-Test"
      secret_name = "${local.secret_name}-Labware-Test-nvrouser"
    },
    {
      username    = "nv_ro_user"
      roles       = ["db_datareader"]
      database    = "Labware-Dev"
      secret_name = "${local.secret_name}-Labware-Dev-nvrouser"
    },
    {
      username    = "nv_report_user"
      roles       = ["db_datareader"]
      database    = "Labware-Prod"
      secret_name = "${local.secret_name}-Labware-Prod-nvreportuser"
    },
    {
      username    = "nv_report_user"
      roles       = ["db_datareader"]
      database    = "Labware-Test"
      secret_name = "${local.secret_name}-Labware-Test-nvreportuser"
    },
    {
      username    = "nv_report_user"
      roles       = ["db_datareader"]
      database    = "Labware-Dev"
      secret_name = "${local.secret_name}-Labware-Dev-nvreportuser"
    },
    {
      username    = "nv_db_owner"
      roles       = ["db_owner"]
      database    = "Labware-Prod"
      secret_name = "${local.secret_name}-Labware-Prod-nvdbowner"
    },
    {
      username    = "nv_db_owner"
      roles       = ["db_owner"]
      database    = "Labware-Test"
      secret_name = "${local.secret_name}-Labware-Test-nvdbowner"
    },
    {
      username    = "nv_db_owner"
      roles       = ["db_owner"]
      database    = "Labware-Dev"
      secret_name = "${local.secret_name}-Labware-Dev-nvdbowner"
    },
    {
      username      = "nv_db_viewreader_bi"
      roles         = ["db_viewreader_bi"]
      database      = "Labware-Dev"
      secret_name   = "${local.secret_name}-Labware-Dev-nvdbviewreaderbi"
      create_secret = true
    },
    {
      username      = "nv_db_viewreader_bi"
      roles         = ["db_viewreader_bi"]
      database      = "Labware-Test"
      secret_name   = "${local.secret_name}-Labware-Test-nvdbviewreaderbi"
      create_secret = true
    },
    {
      username      = "nv_db_viewreader_bi"
      roles         = ["db_viewreader_bi"]
      database      = "Labware-Prod"
      secret_name   = "${local.secret_name}-Labware-Prod-nvdbviewreaderbi"
      create_secret = true
    },
  ]

  private_endpoints = [
    {
      name      = "nv-lims-pe"
      subnet_id = dependency.vnet.outputs.subnets["nv-lims-subnet-10.64.1.32_27"].id
      private_service_connection = {
        name              = "nv-lims-pec"
        subresource_names = ["sqlServer"]
      }
      private_dns_zone_group = {
        name                         = "nv-lims-sql"
        dns_zone_resource_group_name = "core_network"
        dns_zone_name                = "privatelink.database.windows.net"
      }
    }
  ]

  custom_rules = [
    {
      name      = "AllowLocalSubnet"
      subnet_id = dependency.vnet.outputs.subnets["nv-lims-subnet-10.64.1.32_27"].id
    }
  ]
}

