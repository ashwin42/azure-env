terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.2.12"
  #source = "../../../../../../tf-mod-azure//vm"
}

include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

inputs = {
  setup_prefix                           = dependency.global.outputs.setup_prefix
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
  subnet_id                              = dependency.global.outputs.subnet.arx-server-subnet.id
  localadmin_key_name                    = "arx01-nvadmin"
  name                                   = "arx01"
  vm_size                                = "Standard_DS2_v2"
  managed_disk_name                      = "arx01-os_disk"
  managed_disk_type                      = "StandardSSD_LRS"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  localadmin_name                        = "nvadmin"
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = true
  encrypt_disks                          = true
  network_interfaces = [
    {
      name      = "arx01-nic1"
      ipaddress = "10.44.5.21"
      subnet    = dependency.global.outputs.subnet.arx-server-subnet.id
      public_ip = false
    }
  ],
  os_profile_windows_config = {
    enable_automatic_upgrades = false
  }
  data_disks = [
    {
      name                 = "arx01-datadisk1"
      size                 = "20"
      lun                  = "0"
      storage_account_type = "Premium_LRS"
    }
  ],
  custom_rules = [
    {
      name                  = "Labs_MFA_VPN"
      priority              = "200"
      direction             = "Inbound"
      source_address_prefix = "10.16.8.0/23"
      access                = "Allow"
      description           = "Allow connections from Labs MFA VPN clients"
    },
    {
      name                  = "NV-VH_VPN"
      priority              = "210"
      direction             = "Inbound"
      source_address_prefix = "10.10.0.0/21"
      access                = "Allow"
      description           = "Allow connections from NV-VH"
    }
  ]
}
