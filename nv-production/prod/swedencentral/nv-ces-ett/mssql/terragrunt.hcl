terraform {
  source = "git@github.com:northvolt/tf-mod-azure.git//mssql?ref=v0.7.39"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//mssql"
}

dependency "subnet" {
  config_path = "../subnet"
}

# Include all settings from the root terragrunt.hcl file
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  subnet = "${include.root.inputs.setup_prefix}-subnet-10.64.1.192_28"
}

inputs = {
  key_vault_name = "nv-production-core"
  key_vault_rg   = "nv-production-core"
  #subnet_id           = dependency.subnet.outputs.subnet[local.subnet].id
  minimum_tls_version   = "Disabled"
  allow_azure_ip_access = false
  azuread_administrator = {
    group = "NV TechOps Role"
  }
  create_administrator_password = true
  databases = [
    {
      name        = "ces-db-prod-01"
      max_size_gb = 64
    },
  ]
  mssql_azuread_users = [
    {
      username = "NV TechOps Role"
      roles    = ["db_owner"]
      database = "ces-db-prod-01"
    },
  ]
  mssql_local_users = [
    {
      username      = "nv_rw_user"
      roles         = ["db_datawriter"]
      database      = "ces-db-prod-01"
      create_secret = true
    },
    {
      username      = "nv_ro_user"
      roles         = ["db_datareader"]
      database      = "ces-db-prod-01"
      create_secret = true
    },
    {
      username      = "nv_report_user"
      roles         = ["db_datareader"]
      database      = "ces-db-prod-01"
      create_secret = true
    },
    {
      username      = "nv_db_owner"
      roles         = ["db_owner"]
      database      = "ces-db-prod-01"
      create_secret = true
    },
  ]
  private_endpoints = {
    "${include.root.inputs.setup_prefix}-mssql-pe" = {
      name      = "${include.root.inputs.setup_prefix}-mssql-pe"
      subnet_id = dependency.subnet.outputs.subnet[local.subnet].id
      private_service_connection = {
        name              = "${include.root.inputs.setup_prefix}-mssql-pec"
        subresource_names = ["sqlServer"]
      }
      private_dns_zone_group = {
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
      subnet_id = dependency.subnet.outputs.subnet[local.subnet].id
    }
  ]
}
