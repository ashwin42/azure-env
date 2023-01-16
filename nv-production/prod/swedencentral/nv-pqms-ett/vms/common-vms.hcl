dependency "rv" {
  config_path = "../recovery_vault"
}

dependency "vnet" {
  config_path = "../subnet"
}

dependency "wvd" {
  config_path = "../wvd/pqms-ett-wvd-01/"
}

locals {
  name = basename(get_original_terragrunt_dir())
}

inputs = {
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_name                                = local.name
  name                                   = local.name
  vm_size                                = "Standard_B4ms"
  backup_vm                              = true
  create_localadmin_password             = true
  storage_account_name                   = "nvprodbootdiagswc"
  boot_diagnostics_enabled               = true
  ad_join                                = true
  managed_disk_size                      = 127
  wvd_register                           = true
  token                                  = values(dependency.wvd.outputs.tokens)[0]
  host_pool_name                         = keys(dependency.wvd.outputs.host_pools)[0]
  storage_image_reference = {
    sku = "2019-Datacenter"
  }
  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
    timezone                  = "W. Europe Standard Time"
  }
  data_disks = [
    {
      name                 = "${local.name}-datadisk1"
      size                 = "127"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
      caching              = "None"
    }
  ]  
  custom_rules = [
    {
      name                  = "Labs_MFA_VPN"
      priority              = "200"
      direction             = "Inbound"
      source_address_prefix = "10.16.8.0/24"
      description           = "Allow connections from Labs MFA VPN clients"
    },
    {
      name                  = "Ett_MFA_VPN"
      priority              = "201"
      direction             = "Inbound"
      source_address_prefix = "10.240.0.0/21"
      description           = "Allow connections from Ett MFA VPN clients"
    },
  ]
}

