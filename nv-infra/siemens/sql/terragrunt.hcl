terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//sql?ref=v0.2.9"
  #source = "../../../../tf-mod-azure/sql"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name     = "nv_siemens"
  setup_prefix            = "nv-siemens"
  subnet_id               = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv_siemens/providers/Microsoft.Network/virtualNetworks/nv_siemens_vnet/subnets/siemens_system_subnet"
  key_vault_name          = "nv-infra-core"
  key_vault_rg            = "nv-infra-core"
  create_private_endpoint = true
  databases = [
    {
      name = "asco4"
    },
    {
      name = "SiSuite.Access.UAM"
    },
    {
      name = "DesigoCC_HDB"
    },
    {
      name = "Surveillance"
    },
    {
      name = "SurveillanceLogServerV2"
    },
  ]
  custom_rules = [
    {
      name      = "AllowLocalSubnet"
      subnet_id = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/nv_siemens/providers/Microsoft.Network/virtualNetworks/nv_siemens_vnet/subnets/siemens_system_subnet"
    }
  ]
}
