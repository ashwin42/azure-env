terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.9.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
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
  vm_size                                = "Standard_DS3_v2"
  managed_disk_name                      = "arx01-os_disk"
  managed_disk_type                      = "StandardSSD_LRS"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  localadmin_name                        = "nvadmin"
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = true
  encrypt_disks                          = true
  boot_diagnostics_enabled               = true
  install_winrm                          = true
  netbox_role                            = "arx"
  network_interfaces = [
    {
      name = "arx01-nic1"
      ip_configuration = [
        {
          ipconfig_name                 = "arx01-nic1-ipconfig"
          private_ip_address            = "10.44.5.21"
          subnet_id                     = dependency.global.outputs.subnet["arx-server-subnet"].id
          private_ip_address_allocation = "Static"
        }
      ]
    }
  ]

  os_profile_windows_config = {
    enable_automatic_upgrades = false
    provision_vm_agent        = true
    timezone                  = "W. Europe Standard Time"
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
      name                  = "NV-VH_Security"
      priority              = "210"
      direction             = "Inbound"
      source_address_prefix = "10.193.6.0/23"
      access                = "Allow"
      description           = "Allow connections from NV-VH"
    },
    {
      name                  = "Phy-Sec-Access-server"
      priority              = "211"
      direction             = "Inbound"
      source_address_prefix = "10.44.1.101/32"
      access                = "Allow"
      description           = "Allow connections from NV-VH"
    },
  ]
}
