terraform {
  source = "git@github.com:northvolt/tf-mod-azure.git//mssql?ref=v0.7.32"
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

inputs = {
  private_endpoints = {
    "moscura-mssql-pe" = {
      name      = "moscura-mssql-pe"
      subnet_id = dependency.subnet.outputs.subnet["moscura-subnet"].id
      private_service_connection = {
        name              = "moscura-mssql-pec"
        subresource_names = ["sqlServer"]
      }
      private_dns_zone_group = {
        dns_zone_resource_group_name = "core_network"
        dns_zone_name                = "privatelink.database.windows.net"
        dns_zone_subscription_id     = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
      }
    }
  }
  create_administrator_password = true
  allow_azure_ip_access         = false
  public_network_access_enabled = false
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

