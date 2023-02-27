terraform {
  source = "git@github.com:northvolt/tf-mod-azure.git//mssql?ref=v0.7.32"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//mssql"
}

dependency "subnet" {
  config_path = "../subnet"
}

dependency "resource_group" {
  config_path = "../resource_group"
}

# Include all settings from the root terragrunt.hcl file
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  name = "dwa-${include.root.locals.all_vars.project}"
}

inputs = {
  resource_group_name           = dependency.resource_group.outputs.resource_group_name
  setup_prefix                  = include.root.locals.all_vars.project
  key_vault_name                = "nvdwainfrasecrets"
  key_vault_rg                  = "global-rg"
  allow_azure_ip_access         = false
  create_administrator_password = true
  private_endpoints = {
    "${include.root.locals.all_vars.project}-sql-pe" = {
      name      = "${include.root.locals.all_vars.project}-sql-pe"
      subnet_id = dependency.subnet.outputs.subnets["${include.root.locals.all_vars.project}-subnet1"].id
      private_service_connection = {
        name              = "${include.root.locals.all_vars.project}-sql-pec"
        subresource_names = ["sqlServer"]
      }
      private_dns_zone_group = {
        dns_zone_resource_group_name = "core_network"
        dns_zone_name                = "privatelink.database.windows.net"
        dns_zone_subscription_id     = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
      }
    }
  }
  lock_resources = false
  azuread_administrator = {
    group = "NV TechOps Role"
  }
  databases = [
    {
      name = local.name
    },
  ]
  mssql_azuread_users = [
    {
      username = "NV TechOps Role"
      roles    = ["db_owner"]
      database = local.name
    },
    #  {
    #    username = "Add Strama LDS AAD group here"
    #    roles    = ["db_owner"]
    #    database = local.name
    #  },
  ]
  mssql_local_users = [
    {
      username      = "${local.name}-owner"
      roles         = ["db_owner"]
      database      = local.name
      create_secret = true
    },
  ]

}