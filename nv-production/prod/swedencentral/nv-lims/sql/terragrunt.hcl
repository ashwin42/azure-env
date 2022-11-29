terraform {
  source = "git@github.com:northvolt/tf-mod-azure.git//sql?ref=v0.7.5"
  # source = "../../../../../../tf-mod-azure/sql"
}

dependency "vnet" {
  config_path = "../subnet"
}


# Include all settings from the root terragrunt.hcl file
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  key_vault_name                = "nv-production-core"
  key_vault_rg                  = "nv-production-core"
  subnet_id                     = dependency.vnet.outputs.subnet["nv-lims-subnet-10.64.1.32_27"].id
  create_private_endpoint       = true
  lock_resources                = false
  create_administrator_password = true

  custom_rules = [
    {
      name      = "AllowLocalSubnet"
      subnet_id = dependency.vnet.outputs.subnet["nv-lims-subnet-10.64.1.32_27"].id
    }
  ]
}
