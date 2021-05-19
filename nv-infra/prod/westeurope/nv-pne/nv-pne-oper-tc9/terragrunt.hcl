terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.2.15"
}

include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

dependency "wvd" {
  config_path = "../wvd-tc9"
}

inputs = {
  setup_prefix                           = dependency.global.outputs.setup_prefix
  token                                  = dependency.wvd.outputs.token
  host_pool_name                         = dependency.wvd.outputs.host_pool.name
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
  name                                   = "nv-pne-oper-tc9"
  vm_name                                = "nv-pne-oper-tc9"
  vm_size                                = "Standard_B8ms"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = true
  wvd_register                           = true
  storage_image_reference = {
    offer     = "Windows-10",
    publisher = "MicrosoftWindowsDesktop",
    sku       = "20h1-evd",
  }
  os_profile_windows_config = {
  }
  os_profile = {
    admin_username = "domainjoin"
  }
  network_interfaces = [
    {
      name      = "nv-pne-oper-tc9-nic"
      ipaddress = "10.44.5.41"
      subnet    = dependency.global.outputs.subnet["nv-pne-subnet-10.44.5.32"].id
      public_ip = false
    }
  ]
  data_disks = [
    {
      name                 = "nv-pne-oper-tc9_datadisk"
      size                 = "1000"
      lun                  = "0"
      storage_account_type = "StandardSSD_LRS"
    }
  ]
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
      name                  = "NV-Cyclers"
      priority              = "220"
      direction             = "Inbound"
      source_address_prefix = "10.100.250.0/23"
      access                = "Allow"
      description           = "Allow connections from NV-Cyclers"
    }
  ]
}
