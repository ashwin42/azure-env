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

dependency "wvd" {
  config_path = "../wvd"
}

locals {
  name = basename(get_terragrunt_dir())
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
  localadmin_key_name                    = "lv-incore-nvadmin"
  boot_diagnostics_enabled               = true
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = true
  wvd_register                           = true
  install_winrm                          = true
  netbox_role                            = "lv-incore"
  storage_image_reference = {
    sku = "2016-Datacenter",
  }
  os_profile_windows_config = {
    enable_automatic_upgrades = true
    provision_vm_agent        = true
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
      name = "lv-incore-srv-nic"
      ip_configuration = [
        {
          name                          = "lv-incore-srv-nic-ipconfig"
          private_ip_address            = "10.46.0.133"
          subnet_id                     = dependency.global.outputs.subnet["lv-incore-subnet-10.46.0.128-28"].id
          private_ip_address_allocation = "Static"
        }
      ]
    }
  ]
  custom_rules = [
    {
      name                    = "lv-incore-fpu"
      priority                = "220"
      direction               = "Inbound"
      source_address_prefix   = "10.101.221.0/26"
      protocol                = "Tcp"
      destination_port_ranges = ["3306", "5800", "5900"]
      access                  = "Allow"
      description             = "Allow connections from Incore FPU on-prem network"
    },
  ]
}

