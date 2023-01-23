terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//synapse?ref=v0.7.24"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//synapse"
}

dependency "subnet" {
  config_path = "../../../../prod/westeurope/nv-ataccama/subnet"
}

dependency "datalake" {
  config_path = "../datalake"
}

dependency "sql" {
  config_path = "../sql"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  name                                   = "nv-ataccama-synapse-ws-dev"
  storage_data_lake_gen2_filesystem_id   = dependency.datalake.outputs.storage_data_lake_gen2_filesystem.id
  sql_administrator_login                = "nvadmin"
  fetch_sql_administrator_login_password = true
  public_network_access_enabled          = true
  managed_virtual_network_enabled        = false
  allow_azure_ip_access                  = true

  identity = {
    type = "SystemAssigned"
  }

  linked_services = [
    {
      name                 = "ivalua-db-link"
      type                 = "SqlServer"
      type_properties_json = <<JSON
{
  "connectionString": "Server=tcp:nvataccamamasterdatadev.database.windows.net,1433;Initial Catalog=ivaluadev;Persist Security Info=False;User ID=ataccama_sql_ivalua_user;Password=${dependency.sql.outputs.mssql_users_local.ataccama_sql_ivalua_user-ivaluadev.password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}
JSON
    },
  ]

  sql_pools = [
    {
      name     = "nv_ataccama_synapse_pool"
      sku_name = "DW100c"
    },
  ]

  private_endpoints = {
    nv-ataccama-dev-wc-pe = {
      subnet_id = dependency.subnet.outputs.subnet["nv-ataccama-subnet"].id
      private_service_connection = {
        name              = "nv-ataccama-dev-wc-pec"
        subresource_names = ["Sql"]
      }
      private_dns_zone_group = {
        name                         = "nv-ataccama-dev-wc"
        dns_zone_resource_group_name = "core_network"
        dns_zone_name                = "privatelink.azuresynapse.net"
        dns_zone_subscription_id     = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
      }
    }
  }

  iam_assignments = {
    "Synapse Contributor" = {
      groups = [
        "VPN-Ataccama-System-AP",
      ],
    },
  }
}
