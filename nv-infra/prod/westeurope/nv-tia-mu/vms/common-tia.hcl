include {
  path = find_in_parent_folders()
}

dependency "rv" {
  config_path = "../recovery_vault"
}

locals {
  name = format("%s%s", "tia-", basename(get_original_terragrunt_dir()))
}

inputs = {
  name                                   = local.name
  vm_name                                = local.name
  dns_zone                               = "tia-mu.nvlt.co"
  enable_dns                             = true
  dns_subscription_id                    = "4312dfc3-8ec3-49c4-b95e-90a248341dd5" # nv hub
  dns_resource_group_name                = "core_network"
  dns_name                               = basename(get_original_terragrunt_dir())
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_size                                = "Standard_B4ms"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  secrets_key_vault_rg                   = "nv-infra-core"
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = true
  localadmin_key_name                    = "${local.name}-vm-localadmin"
  create_localadmin_password             = true
  storage_image_reference = {
    id = "/subscriptions/11dd160f-0e01-4b4d-a7a0-59407e357777/resourceGroups/tia-mu-rg/providers/Microsoft.Compute/galleries/nvgallery2/images/tia-template/versions/0.0.1"
  }
  os_profile = {
    admin_username = "nvadmin"
    computer_name  = local.name
  }
  data_disks = [
    {
      name                 = "${local.name}-data1"
      size                 = "500"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
    }
  ]
  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
    timezone                  = "W. Europe Standard Time"
  }
  custom_rules = [
    {
      name                   = "Labs_MFA_VPN"
      priority               = "200"
      direction              = "Inbound"
      source_address_prefix  = "10.16.8.0/23"
      protocol               = "*"
      destination_port_range = "3389, 8735"
      access                 = "Allow"
      description            = "Allow connections from Labs MFA VPN clients"
    }
  ]
}
