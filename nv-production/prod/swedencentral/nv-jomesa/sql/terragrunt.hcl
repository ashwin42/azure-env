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

dependency "sql_app" {
  config_path = "../sql_app"
}

# Include all settings from the root terragrunt.hcl file
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  name = "ett-${include.root.inputs.project}"
}

inputs = {
  setup_prefix                  = include.root.inputs.project
  key_vault_name                = "nv-production-core"
  key_vault_rg                  = "nv-production-core"
  allow_azure_ip_access         = false
  create_administrator_password = true
  minimum_tls_version           = "1.0"
  private_endpoints = [
     {
      name      = "${include.root.inputs.project}-sql-pe"
      subnet_id = dependency.subnet.outputs.subnets["${include.root.inputs.project}-subnet1"].id
      private_service_connection = {
        name              = "${include.root.inputs.project}-sql-pec"
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
      subnet_id = dependency.subnet.outputs.subnets["${include.root.inputs.project}-subnet1"].id
    },
  ]

  databases = [
    {
      name = "Jomesa_prod_DB"
      long_term_retention_policy1 = {
        weekly_retention = "P8W"
      }
    },
  ]

  mssql_user_client_id     = dependency.sql_app.outputs.client_id
  mssql_user_client_secret = dependency.sql_app.outputs.service_principal_password
  mssql_local_users = [
    {
      username      = "${local.name}-owner"
      roles         = ["db_owner"]
      database      = "Jomesa_prod_DB"
      create_secret = true
    },
    {
      username      = "${local.name}-rw-user"
      roles         = ["db_datareader", "db_datawriter"]
      database      = "Jomesa_prod_DB"
      create_secret = true
    },
  ]
}
