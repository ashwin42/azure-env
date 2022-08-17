terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//sql?ref=v0.5.4"
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

inputs = {
  resource_group_name           = dependency.resource_group.outputs.resource_group_name
  setup_prefix                  = dependency.resource_group.outputs.setup_prefix
  subnet_id                     = dependency.vnet.outputs.subnet.databases.id
  key_vault_name                = replace("${include.root.locals.all_vars.subscription_name}-rg", "_", "-")
  key_vault_rg                  = replace("${include.root.locals.all_vars.subscription_name}-rg", "_", "-")
  create_administrator_password = true
  create_private_endpoint       = true
  public_network_access_enabled = false
  allow_azure_ip_access         = false
  license_type                  = "LicenseIncluded"
  databases = [
    {
      name = dependency.resource_group.outputs.setup_prefix
    },
  ]
}

