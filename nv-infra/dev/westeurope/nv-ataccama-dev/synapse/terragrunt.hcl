terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//synapse?ref=v0.10.14"
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

include {
  path = find_in_parent_folders()
}

inputs = {
  name                                   = "nv-ataccama-synapse-ws-dev"
  storage_data_lake_gen2_filesystem_id   = dependency.datalake.outputs.data_lake_gen2_filesystems.dlmasterdataataccamadev-dl.id
  sql_administrator_login                = "nvadmin"
  fetch_sql_administrator_login_password = true
  public_network_access_enabled          = true
  managed_virtual_network_enabled        = false
  allow_azure_ip_access                  = true

  sql_aad_admin = {
    group = "NV TechOps Role"
  }

  identity = {
    type = "SystemAssigned"
  }

  firewall_rules = [
    {
      name             = "ALL"
      start_ip_address = "0.0.0.0"
      end_ip_address   = "255.255.255.255"
    },
  ]

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

  private_endpoints = [
    {
      name      = "nv-ataccama-dev-wc-pe"
      subnet_id = dependency.subnet.outputs.subnets["nv-ataccama-subnet"].id
      private_service_connection = {
        name              = "nv-ataccama-dev-wc-pec"
        subresource_names = ["Sql"]
      }
      private_dns_zone_group = {
        name                         = "nv-ataccama-dev-wc"
        dns_zone_resource_group_name = "core_network"
        dns_zone_name                = "privatelink.azuresynapse.net"
      }
    }
  ]

  role_assignments = [
    {
      role_name      = "Synapse Administrator"
      group          = "NV TechOps Role"
      principal_type = "Group"
    },
    {
      role_name      = "Synapse Administrator"
      group          = "Ataccama - Datalake Admins Dev"
      principal_type = "Group"
    },
    {
      role_name      = "Synapse Contributor"
      group          = "Ataccama - Datalake Admins Dev"
      principal_type = "Group"
    },
    {
      role_name      = "Synapse SQL Administrator"
      group          = "Ataccama - Datalake Admins Dev"
      principal_type = "Group"
    },
  ]
}
