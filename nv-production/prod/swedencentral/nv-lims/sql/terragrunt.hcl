terraform {
  source = "git@github.com:northvolt/tf-mod-azure.git//mssql?ref=v0.7.19"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//mssql"
}

dependency "vnet" {
  config_path = "../subnet"
}

dependency "sql_app" {
  config_path = "../sql_app"
}

# Include all settings from the root terragrunt.hcl file
include "root" {
  path = find_in_parent_folders()
}

locals {
  secret_name = "${basename(dirname(get_terragrunt_dir()))}-${basename(get_terragrunt_dir())}"
}

inputs = {
  key_vault_name      = "nv-production-core"
  key_vault_rg        = "nv-production-core"
  subnet_id           = dependency.vnet.outputs.subnet["nv-lims-subnet-10.64.1.32_27"].id
  lock_resources      = false
  minimum_tls_version = "Disabled"
  azuread_administrator = {
    group = "Labware LIMS Developers"
  }
  create_administrator_password = true
  databases = [
    {
      name     = "Labware-Prod"
      sku_name = "GP_Gen5_4"
    },
    {
      name = "Labware-Test"
    },
    {
      name = "Labware-Dev"
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
  ]
  private_endpoints = {
    "nv-lims-pe" = {
      subnet_id = dependency.vnet.outputs.subnet["nv-lims-subnet-10.64.1.32_27"].id
      private_service_connection = {
        name              = "nv-lims-pec"
        subresource_names = ["sqlServer"]
      }
      private_dns_zone_group = {
        name                         = "nv-lims-sql"
        dns_zone_resource_group_name = "core_network"
        dns_zone_name                = "privatelink.database.windows.net"
        dns_zone_subscription_id     = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
        dns_record_ttl               = 300
      }
    }
  }
  custom_rules = [
    {
      name      = "AllowLocalSubnet"
      subnet_id = dependency.vnet.outputs.subnet["nv-lims-subnet-10.64.1.32_27"].id
    }
  ]
}
