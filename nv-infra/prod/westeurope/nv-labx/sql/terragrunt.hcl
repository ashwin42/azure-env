terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//sql?ref=v0.2.14"
  #source = "../../../../tf-mod-azure/sql"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

inputs = {
  resource_group_name     = dependency.global.outputs.resource_group.name
  setup_prefix            = dependency.global.outputs.setup_prefix
  subnet_id               = dependency.global.outputs.subnet.labx_subnet.id
  key_vault_name          = "nv-infra-core"
  key_vault_rg            = "nv-infra-core"
  create_private_endpoint = true
  databases = [
    {
      name = "Labware"
    },
    {
      name = "Labware-Test"
    },
    {
      name = "Labware-Prod"
    },
    {
      name = "Labware-Dev"
    },
  ]
  custom_rules = [
    {
      name      = "AllowLocalSubnet"
      subnet_id = dependency.global.outputs.subnet.labx_subnet.id
    }
  ]
}
