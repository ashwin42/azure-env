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

dependency "wvd" {
  config_path = "../wvd-training"
}

locals {
  name = "lims-training"
}

inputs = {
  setup_prefix                           = local.name
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
  localadmin_name                        = "nvadmin"
  localadmin_key_name                    = "nv-labx"
  ad_join                                = true
  wvd_register                           = true
  boot_diagnostics_enabled               = true
  managed_disk_name                      = "lims-training-vm-osdisk"

  storage_image_reference = {
    offer     = "Windows-10",
    publisher = "MicrosoftWindowsDesktop",
    sku       = "21h1-evd",
  }

  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
    timezone                  = "W. Europe Standard Time"
  }

  network_security_groups = [
    {
      name               = "lims-training-vm-nsg"
      move_default_rules = true
      rules = [
        {
          name                   = "Local_VNET_SQL"
          priority               = "230"
          direction              = "Inbound"
          source_address_prefix  = dependency.vnet.outputs.subnets.labx_subnet.address_prefixes.0
          protocol               = "Tcp"
          destination_port_range = "1433"
          access                 = "Allow"
          description            = "Allow connections from local VNET"
        },
        {
          name                   = "Local_VNET_SQL_Browser"
          priority               = "235"
          direction              = "Inbound"
          source_address_prefix  = dependency.vnet.outputs.subnets.labx_subnet.address_prefixes.0
          protocol               = "Udp"
          destination_port_range = "1434"
          access                 = "Allow"
          description            = "Allow connections from local VNET"
        },
      ]
    },
  ]

  network_interfaces = [
    {
      name                = "${local.name}-0-nic"
      security_group_name = "lims-training-vm-nsg"
      ip_configuration = [
        {
          private_ip_address            = "10.44.2.13"
          subnet_id                     = dependency.vnet.outputs.subnets.labx_subnet.id
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "${local.name}-0-nic-ipconfig"
        },
      ]
    },
  ]
}
