terraform {
  source = "git@github.com:northvolt/tf-mod-azure.git//mssql?ref=v0.10.7"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//mssql"
}

dependency "subnet" {
  config_path = "../subnet"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name                          = include.root.locals.all_vars.project
  resource_group_name           = include.root.inputs.resource_group_name
  key_vault_name                = include.root.inputs.secrets_key_vault_name
  key_vault_rg                  = include.root.inputs.secrets_key_vault_rg
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

  azuread_administrator = {
    group = "NV TechOps Role"
  }

  databases = [
    {
      name = "nextgen"
    },
  ]

  mssql_azuread_users = [
    {
      username = "NV TechOps Role"
      roles    = ["db_owner"]
      database = "nextgen"
    },
    {
      username = "Tomteboda BuildData SQL VPN Access"
      roles    = ["db_writer"]
      database = "nextgen"
    },
  ]

  custom_rules = [
    {
      name      = "AllowLocalSubnet"
      subnet_id = dependency.subnet.outputs.subnets["${include.root.inputs.project}-subnet1"].id
    },
  ]
}
