terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.7.44"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vm/"
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
  subnet_id                              = dependency.global.outputs.subnet["nv-e3-subnet-10.44.5.128"].id
  vm_size                                = "Standard_D3_v2"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  localadmin_key_name                    = "nv-e3-nvadmin"
  storage_account_name                   = "nvinfrabootdiag"
  boot_diagnostics_enabled               = true
  ad_join                                = true
  wvd_register                           = true

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
    admin_username = "nv-e3-nvadmin"
    computer_name  = "nv-e3-vm"
  }

  network_interfaces = [
    {
      name                = "${local.name}-nic"
      security_group_name = "nv-e3-vm-nsg"
      ip_configuration = [
        {
          private_ip_address            = "10.44.5.132"
          subnet_id                     = dependency.global.outputs.subnet["nv-e3-subnet-10.44.5.128"].id
          public_ip                     = false
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "${local.name}-nic-ipconfig"
        },
      ]
    },
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
