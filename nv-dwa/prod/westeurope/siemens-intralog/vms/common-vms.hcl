include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "rv" {
  config_path = "../../global/recovery_vault"
}

dependency "storage" {
  config_path = "../../global/storage"
}
dependency "vault" {
  config_path = "../../global/vaults/secrets"
}

# Using the subnet module from WCS as those VMs are related to WCS
dependency "subnet" {
  config_path = "../../siemens-wcs/subnet"
}

locals {
  name    = basename(get_original_terragrunt_dir())
  vm_name = format("intralog-%s", replace(local.name, "bound", ""))
}

inputs = {
  vm_name                                = local.vm_name
  setup_prefix                           = include.root.locals.all_vars.project
  resource_group_name                    = include.root.locals.all_vars.resource_group_name
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_size                                = "Standard_B4ms"
  backup_vm                              = true
  secrets_key_vault_name                 = dependency.vault.outputs.azurerm_key_vault.name
  secrets_key_vault_rg                   = dependency.vault.outputs.azurerm_key_vault.resource_group_name
  ad_join_secrets_key_vault_name         = "nv-infra-core"
  ad_join_secrets_key_vault_rg           = "nv-infra-core"
  create_localadmin_password             = true
  localadmin_name                        = "nvadmin"
  localadmin_key_name                    = "${local.vm_name}-nvadmin"
  storage_account_name                   = dependency.storage.outputs.storage_account_name
  ad_join                                = "true"
  storage_image_reference = {
    sku = "2022-Datacenter-smalldisk",
  }
  os_profile_windows_config = {
    enable_automatic_upgrades = true
    provision_vm_agent        = true
    timezone                  = "W. Europe Standard Time"
  }
  boot_diagnostics_enabled = true
  managed_disk_name        = "${local.vm_name}-osdisk"
  data_disks = [
    {
      name                 = "${include.root.locals.all_vars.project}-${local.name}-data1"
      size                 = "20"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
    },
    {
      name                 = "${include.root.locals.all_vars.project}-${local.name}-data2"
      size                 = "40"
      lun                  = "6"
      storage_account_type = "StandardSSD_LRS"
    }
  ]
  custom_rules = [
    {
      name                  = "Labs_MFA_VPN"
      priority              = "200"
      direction             = "Inbound"
      source_address_prefix = "10.16.8.0/23"
      description           = "Allow connections from Labs MFA VPN clients"
    },
    {
      name                  = "Ett_MFA_VPN"
      priority              = "201"
      direction             = "Inbound"
      source_address_prefix = "10.240.0.0/21"
      description           = "Allow connections from Labs MFA VPN clients"
    },
  ]
}
