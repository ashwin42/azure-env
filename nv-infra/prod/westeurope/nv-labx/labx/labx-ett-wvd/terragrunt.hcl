terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.8.0"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../../vnet"
}

dependency "rv" {
  config_path = "../../recovery_vault"
}

dependency "wvd-ett" {
  config_path = "../wvd-ett"
}

locals {
  name = "nv-ett-labx-wvd"
}

inputs = {
  token                                  = dependency.wvd-ett.outputs.token
  host_pool_name                         = dependency.wvd-ett.outputs.host_pool.name
  wvd_extension_name                     = "labx-ett-wvd-wvd_dsc"
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  subnet_id                              = dependency.vnet.outputs.subnets.labx_subnet.id
  vm_name                                = local.name
  name                                   = local.name
  vm_size                                = "Standard_DS4_v2"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  create_localadmin_password             = true
  boot_diagnostics_enabled               = true
  ad_join                                = true
  wvd_register                           = true
  localadmin_key_name                    = "labx-ett-wvd-nvadmin"

  storage_image_reference = {
    offer     = "Windows-10",
    publisher = "MicrosoftWindowsDesktop",
    sku       = "20h1-evd",
  }

  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
    timezone                  = "W. Europe Standard Time"
  }

  os_profile = {
    admin_username = "nv-labx-nvadmin"
    computer_name  = local.name
  }

  data_disks = [
    {
      name                 = "${local.name}-datadisk1"
      size                 = 100
      storage_account_type = "Standard_LRS"
      lun                  = 10
    }
  ]

  network_security_groups = [
    {
      name               = "nv-ett-labx-wvd-nsg"
      move_default_rules = true
      rules              = []
    },
  ]

  network_interfaces = [
    {
      name                = "${local.name}-nic"
      security_group_name = "nv-ett-labx-wvd-nsg"
      ip_configuration = [
        {
          private_ip_address            = "10.44.2.21"
          subnet_id                     = dependency.vnet.outputs.subnets.labx_subnet.id
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "${local.name}-nic-ipconfig"
        },
      ]
    },
  ]
}

