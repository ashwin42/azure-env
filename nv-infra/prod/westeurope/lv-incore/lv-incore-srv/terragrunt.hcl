terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.2.14"
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

locals {
  name = "lv-incore-srv"
}

inputs = {
  setup_prefix                           = dependency.global.outputs.setup_prefix
  token                                  = dependency.wvd.outputs.token
  host_pool_name                         = dependency.wvd.outputs.host_pool.name
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
  vm_name                                = local.name
  name                                   = local.name
  vm_size                                = "Standard_B4ms"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = true
  wvd_register                           = true
  storage_image_reference = {
    sku = "2016-Datacenter",
  }
  os_profile_windows_config = {
    enable_automatic_upgrades = true
    timezone                  = "W. Europe Standard Time"
  }
  os_profile = {
    admin_username = "nvadmin"
    computer_name  = local.name
  }
  data_disks = [
    {
      name                 = "${local.name}-data1"
      size                 = "3000"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
    },
  ]
  network_interfaces = [
    {
      name      = "${local.name}-nic"
      ipaddress = "10.46.0.133"
      subnet    = dependency.global.outputs.subnet["lv-incore-subnet-10.46.0.128-28"].id
      public_ip = false
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
      name                   = "lv-incore-fpu"
      priority               = "220"
      direction              = "Inbound"
      source_address_prefix  = "10.101.221.0/26"
      protocol               = "TCP"
      destination_port_range = "3306,5800,5900"
      access                 = "Allow"
      description            = "Allow connections from Incore FPU on-prem network"
    },
  ]
}

