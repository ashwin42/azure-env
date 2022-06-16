terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//sql?ref=v0.2.23"
  #source = "../../../../../../tf-mod-azure/sql"
}

dependency "subnet" {
  config_path = "../subnet"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  key_vault_name                = "nv-infra-core"
  key_vault_rg                  = "nv-infra-core"
  subnet_id                     = dependency.subnet.outputs.subnet["nv-toolsnet-subnet-10.46.1.16_28"].id
  create_private_endpoint       = true
  lock_resources                = false
  public_network_access_enabled = false
  databases = [
    {
      name     = "toolsnet"
      edition  = "Standard"
      max_size = "268435456000"
    },
  ]
  custom_rules = [
    {
      name      = "AllowLocalSubnet"
      subnet_id = dependency.subnet.outputs.subnet["nv-toolsnet-subnet-10.46.1.16_28"].id
    }
  ]
}
