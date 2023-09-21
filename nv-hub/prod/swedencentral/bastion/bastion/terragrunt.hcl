terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//bastion?ref=v0.8.1"
  # source = "${dirname(get_repo_root())}//tf-mod-azure/bastion/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../../vnet-hub"
}

inputs = {
  name               = "bastion-prod-${include.root.locals.all_vars.location}"
  sku                = "Standard"
  ip_connect_enabled = true
  ip_configuration = {
    name      = "bastion-ip-${include.root.locals.all_vars.location}"
    subnet_id = dependency.vnet.outputs.subnet["AzureBastionSubnet"].id
  }
}

