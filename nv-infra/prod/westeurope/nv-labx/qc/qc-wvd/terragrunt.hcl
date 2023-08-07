terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.8.0"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm"
}

include {
  path = find_in_parent_folders()
}

dependency "vnet" {
  config_path = "../../vnet"
}

dependency "rv" {
  config_path = "../../recovery_vault"
}

dependency "wvd" {
  config_path = "../wvd"
}

locals {
  name = "nv-qc-wvd-0"
}

inputs = {
  token                                  = dependency.wvd.outputs.token
  host_pool_name                         = dependency.wvd.outputs.host_pool.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  subnet_id                              = dependency.vnet.outputs.subnets.labx_subnet.id
  vm_name                                = local.name
  vm_size                                = "Standard_DS4_v2"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  storage_account_name                   = "nvinfrabootdiag"
  boot_diagnostics_enabled               = true
  localadmin_key_name                    = "nv-labx"
  ad_join                                = true
  wvd_register                           = true
  wvd_extension_name                     = "nv-labx-wvd_dsc"
  managed_disk_size                      = "256"
  managed_disk_name                      = "nv-labx-vm-osdisk"

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

  network_security_groups = [
    {
      name               = "nv-labx-vm-nsg"
      move_default_rules = true
      rules              = []
    },
  ]

  network_interfaces = [
    {
      name                = "${local.name}-nic"
      security_group_name = "nv-labx-vm-nsg"
      ip_configuration = [
        {
          ipaddress                     = "10.44.2.10"
          subnet_id                     = dependency.vnet.outputs.subnets.labx_subnet.id
          public_ip                     = false
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "${local.name}-nic-ipconfig"
        },
      ]
    },
  ]
}
