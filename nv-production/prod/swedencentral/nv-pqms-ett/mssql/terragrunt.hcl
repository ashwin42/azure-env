terraform {
  source = "git@github.com:northvolt/tf-mod-azure.git//mssql?ref=v0.7.21"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//mssql"
}

dependency "vnet" {
  config_path = "../subnet"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  create_administrator_password = true
  allow_azure_ip_access         = false
  public_network_access_enabled = false
  private_endpoints = {
    "pqms-ett-mssql-pe" = {
      name      = "pqms-ett-mssql-pe"
      subnet_id = dependency.vnet.outputs.subnet["pqms-subnet"].id
      private_service_connection = {
        name              = "pqms-ett-mssql-pec"
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
      subnet_id = dependency.vnet.outputs.subnet["pqms-subnet"].id
    }
  ]
  azuread_administrator = {
    group = "NV TechOps Role"
  }
  databases = [
    {
      name = "pqms-ett-syslog",
    },
    {
      name = "pqms-ett-data",
    },
    {
      name = "pqms-ett-netconf",
    },
    {
      name = "pqms-ett-appconf",
    },
  ]
  mssql_azuread_users = [
    {
      username = "NV TechOps Role"
      roles    = ["db_owner"]
      database = "pqms-ett-syslog"
    },
    {
      username = "NV TechOps Role"
      roles    = ["db_owner"]
      database = "pqms-ett-data"
    },
    {
      username = "NV TechOps Role"
      roles    = ["db_owner"]
      database = "pqms-ett-netconf"
    },
    {
      username = "NV TechOps Role"
      roles    = ["db_owner"]
      database = "pqms-ett-appconf"
    },
  ]
  mssql_local_users = [
    {
      username      = "syslog-admin"
      roles         = ["db_owner"]
      database      = "pqms-ett-syslog"
      create_secret = true
    },
    {
      username      = "data-admin"
      roles         = ["db_owner"]
      database      = "pqms-ett-data"
      create_secret = true
    },
    {
      username      = "net-admin"
      roles         = ["db_owner"]
      database      = "pqms-ett-netconf"
      create_secret = true
    },
    {
      username      = "app-admin"
      roles         = ["db_owner"]
      database      = "pqms-ett-appconf"
      create_secret = true
    },
  ]
}

