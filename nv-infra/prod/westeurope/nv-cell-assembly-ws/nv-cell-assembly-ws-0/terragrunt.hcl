terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.2.12"
}

include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

dependency "wvd" {
  config_path = "../wvd"
}

inputs = {
  setup_prefix                           = dependency.global.outputs.setup_prefix
  token                                  = dependency.wvd.outputs.token
  host_pool_name                         = dependency.wvd.outputs.host_pool.name
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
  subnet_id                              = dependency.global.outputs.subnet["nv-cell-assembly-ws-subnet-10.44.5.96"].id
  vm_name                                = "nv-ca-ws-0"
  vm_size                                = "Standard_D3_v2"
  backup_vm                              = false
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
    enable_automatic_upgrades = true
    timezone                  = "W. Europe Standard Time"
  }
  os_profile = {
    admin_username = "domainjoin"
    computer_name  = "nv-ca-ws-0"
  }
  network_interfaces = [
    {
      name      = "nv-ca-ws-0-nic"
      ipaddress = "10.44.5.100"
      subnet    = dependency.global.outputs.subnet["nv-cell-assembly-ws-subnet-10.44.5.96"].id
      public_ip = false
    }
  ]
  data_disks = [
    {
      name                 = "nv-ca-ws-0_datadisk"
      size                 = "100"
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
    }
  ]
}
