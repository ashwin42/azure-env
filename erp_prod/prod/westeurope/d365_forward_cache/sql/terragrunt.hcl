terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//sql?ref=v0.5.5"
  #source = "../../../../../../tf-mod-azure/sql"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "resource_group" {
  config_path = "../resource_group"
}

dependency "vnet" {
  config_path = "../../vnet"
}

dependency "sql_group" {
  config_path = "../sql_group"
}

dependency "sql_app" {
  config_path = "../sql_app"
}

inputs = {
  resource_group_name           = dependency.resource_group.outputs.resource_group_name
  setup_prefix                  = dependency.resource_group.outputs.setup_prefix
  subnet_id                     = dependency.vnet.outputs.subnet.databases.id
  key_vault_name                = replace("${include.root.locals.all_vars.subscription_name}-rg", "_", "-")
  key_vault_rg                  = replace("${include.root.locals.all_vars.subscription_name}-rg", "_", "-")
  create_administrator_password = true
  create_private_endpoint       = true
  public_network_access_enabled = true
  allow_azure_ip_access         = true
  license_type                  = "LicenseIncluded"
  enable_private_dns            = true
  ad_admin_login_group          = values(dependency.sql_group.outputs.groups)[0].display_name
  mssql_user_client_id          = dependency.sql_app.outputs.client_id
  mssql_user_client_secret      = dependency.sql_app.outputs.service_principal_password
  mssql_azuread_users = [
    {
      username = "NV Techops Role"
      roles    = ["db_owner"]
      database = dependency.resource_group.outputs.setup_prefix
    },
    {
      username = values(dependency.sql_group.outputs.groups)[0].display_name
      roles    = ["db_owner"]
      database = dependency.resource_group.outputs.setup_prefix

    }
  ]
  databases = [
    {
      name = dependency.resource_group.outputs.setup_prefix
    },
  ]
}
