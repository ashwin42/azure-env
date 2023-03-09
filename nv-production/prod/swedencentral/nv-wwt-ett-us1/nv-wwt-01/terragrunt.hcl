terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.7.22"
  #source = "../../../../../../tf-mod-azure//vm/"
}

include {
  path = find_in_parent_folders()
}

dependency "vnet" {
  config_path = "../subnet"
}

dependency "wvd" {
  config_path = "../wvd/01"
}

dependency "rv" {
  config_path = "../recovery_vault"
}

locals {
  name            = basename(get_terragrunt_dir())
  localadmin_name = "nvadmin"
}

inputs = {
  token                                  = values(dependency.wvd.outputs.tokens)[0]
  host_pool_name                         = keys(dependency.wvd.outputs.host_pools)[0]
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_name                                = local.name
  name                                   = local.name
  vm_size                                = "Standard_B4ms"
  backup_vm                              = true
  key_vault_name                         = "nv-production-core"
  key_vault_rg                           = "nv-production-core"
  localadmin_name                        = local.localadmin_name
  localadmin_key_name                    = "${local.name}-${local.localadmin_name}"
  create_localadmin_password             = true
  storage_account_name                   = "nvprodbootdiagswc"
  boot_diagnostics_enabled               = true
  ad_join                                = true
  azuread_join                           = false
  wvd_register                           = true
  managed_disk_size                      = 250
  identity = {
    type         = "SystemAssigned"
    identity_ids = null
  }
  storage_image_reference = {
    offer     = "Windows-10",
    publisher = "MicrosoftWindowsDesktop",
    sku       = "21h1-evd-g2",
  }
  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
    timezone                  = "W. Europe Standard Time"
  }
  os_profile = {
    admin_username = local.localadmin_name
    computer_name  = local.name
  }
  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          private_ip_address            = "10.64.1.20"
          subnet_id                     = dependency.vnet.outputs.subnet["nv-wwt-subnet-10.64.1.16_28"].id
          public_ip                     = false
          private_ip_address_allocation = "Static"
          #ipconfig_name                 = "ipconfig"
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
      name                   = "Ett_MFA_VPN"
      priority               = "201"
      direction              = "Inbound"
      source_address_prefix  = "10.240.0.0/21"
      protocol               = "*"
      destination_port_range = "0-65535"
      access                 = "Allow"
      description            = "Allow connections from Ett MFA VPN clients"
    },
    {
      name                   = "WWT_WS_102"
      priority               = "202"
      direction              = "Inbound"
      source_address_prefix  = "10.14.16.96/32"
      protocol               = "Tcp"
      destination_port_range = "102"
      access                 = "Allow"
      description            = "Allow connections from wwt-workstation"
    },
    {
      name                   = "WWT_S1_102"
      priority               = "203"
      direction              = "Inbound"
      source_address_prefix  = "10.14.16.145/32"
      protocol               = "Tcp"
      destination_port_range = "102"
      access                 = "Allow"
      description            = "Allow connections from wwt-server01"
    },
    {
      name                   = "WWT_S2_102"
      priority               = "204"
      direction              = "Inbound"
      source_address_prefix  = "10.14.16.6/32"
      protocol               = "Tcp"
      destination_port_range = "102"
      access                 = "Allow"
      description            = "Allow connections from wwt-server02"
    },
  ]
}

