terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.2.37"
}

include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
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
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
  subnet_id                              = dependency.global.outputs.subnet.labx_subnet.id
  vm_name                                = local.name
  vm_size                                = "Standard_DS4_v2"
  backup_vm                              = false
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  storage_account_name                   = "nvinfrabootdiag"
  localadmin_name                        = "nvadmin"
  localadmin_key_name                    = "nv-labx"
  ad_join                                = true
  wvd_register                           = true
  boot_diagnostics_enabled               = true
  storage_image_reference = {
    offer     = "Windows-10",
    publisher = "MicrosoftWindowsDesktop",
    sku       = "21h1-evd",
  }
  os_profile_windows_config = {
    enable_automatic_upgrades = true
    timezone                  = "W. Europe Standard Time"
  }
  network_interfaces = [
    {
      name = "${local.name}-0-nic"
      ip_configuration = [
        {
          private_ip_address            = "10.44.2.13"
          subnet_id                     = dependency.global.outputs.subnet.labx_subnet.id
          public_ip                     = false
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "${local.name}-0-nic-ipconfig"
        },
      ]
    },
  ]
  custom_rules = [
    {
      name                   = "Labs_MFA_VPN"
      priority               = "200"
      direction              = "Inbound"
      source_address_prefix  = "10.16.8.0/23"
      protocol               = "*"
      destination_port_range = "0-65535"
      access                 = "Allow"
      description            = "Allow connections from Labs MFA VPN clients"
    },
    {
      name                   = "Local_VNET_SQL"
      priority               = "230"
      direction              = "Inbound"
      source_address_prefix  = dependency.global.outputs.subnet.labx_subnet.address_prefix
      protocol               = "tcp"
      destination_port_range = "1433"
      access                 = "Allow"
      description            = "Allow connections from local VNET"
    },
    {
      name                   = "Local_VNET_SQL_Browser"
      priority               = "235"
      direction              = "Inbound"
      source_address_prefix  = dependency.global.outputs.subnet.labx_subnet.address_prefix
      protocol               = "udp"
      destination_port_range = "1434"
      access                 = "Allow"
      description            = "Allow connections from local VNET"
    },
  ]
}
