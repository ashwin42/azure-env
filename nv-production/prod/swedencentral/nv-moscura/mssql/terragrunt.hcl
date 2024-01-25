terraform {
  source = "git@github.com:northvolt/tf-mod-azure.git//mssql?ref=v0.10.13"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//mssql"
}

dependency "subnet" {
  config_path = "../subnet"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  secret_name = "nv-moscura-sqladmin"

  private_endpoints = [
    {
      name      = "moscura-mssql-pe"
      subnet_id = dependency.subnet.outputs.subnets["moscura-subnet"].id
      private_service_connection = {
        name              = "moscura-mssql-pec"
        subresource_names = ["sqlServer"]
      }
      private_dns_zone_group = {
        dns_zone_resource_group_name = "core_network"
        dns_zone_name                = "privatelink.database.windows.net"
      }
    }
  ]

  create_administrator_password = true
  allow_azure_ip_access         = false
  public_network_access_enabled = false
  connection_policy             = "Redirect"

  azuread_administrator = {
    group = "NV TechOps Role"
  }

  databases = [
    {
      name = "moscura-db-01"
    },
  ]

  mssql_azuread_users = [
    {
      username = "NV TechOps Role"
      roles    = ["db_owner"]
      database = "moscura-db-01"
    },
  ]

  mssql_local_users = [
    {
      username      = "moscura-admin"
      roles         = ["db_owner"]
      database      = "moscura-db-01"
      create_secret = true
    },
  ],
}

