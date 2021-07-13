terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//sql?ref=v0.2.15"
  #source = "../../../../../../tf-mod-azure/sql"
}

dependency "global" {
  config_path = "../global"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name     = dependency.global.outputs.resource_group.name
  setup_prefix            = dependency.global.outputs.setup_prefix
  key_vault_name          = "nv-infra-core"
  key_vault_rg            = "nv-infra-core"
  subnet_id               = dependency.global.outputs.subnet["nv-cmx-subnet-10.46.0.64-28"].id
  create_private_endpoint = true
  lock_resources          = false
  databases = [
    {
      name = "cmx"
    },
  ]
  custom_rules = [
    {
      name      = "AllowLocalSubnet"
      subnet_id = dependency.global.outputs.subnet["nv-cmx-subnet-10.46.0.64-28"].id
    }
  ]
}
