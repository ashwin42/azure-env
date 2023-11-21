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
  name = "nv-ca-ws-0"
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
  vm_size                                = "Standard_D3_v2"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  storage_account_name                   = "nvinfrabootdiag"
  localadmin_key_name                    = "nv-cell-assembly-ws-nvadmin"
  boot_diagnostics_enabled               = true
  ad_join                                = true
  wvd_register                           = true
  install_winrm                          = true
  netbox_role                            = "cellassembly-ws"

  storage_os_disk = {
    name = "nv-cell-assembly-ws-vm-osdisk"
  }

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
    admin_username = "domainjoin"
    computer_name  = local.name
  }

  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          private_ip_address            = "10.44.5.100"
          subnet_id                     = dependency.global.outputs.subnet["nv-cell-assembly-ws-subnet-10.44.5.96"].id
          public_ip                     = false
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "${local.name}-nic-ipconfig"
        },
      ]
    },
  ]

  data_disks = [
    {
      name                 = "${local.name}_datadisk"
      size                 = "100"
      lun                  = "0"
      storage_account_type = "StandardSSD_LRS"
    }
  ]
}
