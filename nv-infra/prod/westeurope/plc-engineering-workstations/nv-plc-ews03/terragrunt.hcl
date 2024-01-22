terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.10.7"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../subnet"
}

dependency "rv" {
  config_path = "../recovery_vault"
}

locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  name                                   = local.name
  vm_size                                = "Standard_D4_v4"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  localadmin_key_name                    = "nv-plc-ews-nvadmin"
  storage_account_name                   = "nvinfrabootdiag"
  boot_diagnostics_enabled               = true
  ad_join                                = true
  install_winrm                          = true
  netbox_role                            = "workstation"
  storage_image_reference = {
    offer     = "Windows-10",
    publisher = "MicrosoftWindowsDesktop",
    sku       = "21h1-evd-g2",
  }
  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
    timezone                  = ""
  }
  os_profile = {
    admin_username = "nvadmin"
    computer_name  = local.name
  }
  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          private_ip_address            = "10.46.1.38"
          subnet_id                     = dependency.vnet.outputs.subnets["nv-plc-ews-10.46.1.32_28"].id
          public_ip                     = false
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "ipconfig"
        },
      ]
    },
  ]
  data_disks = [
    {
      name                     = "${local.name}_datadisk"
      size                     = "75"
      lun                      = "0"
      storage_account_type     = "StandardSSD_LRS"
      create_option_attachment = "Attach"
    }
  ]
  custom_rules = [
    {
      name                   = "octoplant-labs_Allow_64001-64006"
      priority               = "400"
      direction              = "Inbound"
      source_address_prefix  = "10.46.1.12/32"
      protocol               = "Tcp"
      destination_port_range = "64001-64006"
      access                 = "Allow"
      description            = "Allow neccessary ports 64001-64006 from octoplant-labs"
    },
    {
      name                   = "octoplant-labs_Allow_64021"
      priority               = "401"
      direction              = "Inbound"
      source_address_prefix  = "10.46.1.12/32"
      protocol               = "Tcp"
      destination_port_range = "64021"
      access                 = "Allow"
      description            = "Allow neccessary port 64021 from octoplant-labs"
    },
    {
      name                   = "FL.A1_Range_1"
      priority               = "402"
      direction              = "Inbound"
      source_address_prefix  = "10.101.196.0/23"
      protocol               = "Tcp"
      destination_port_range = "*"
      access                 = "Allow"
      description            = "Allow traffic from non-deterministic network in FL.A1"
    },
    {
      name                   = "FL.A1_Range_2"
      priority               = "403"
      direction              = "Inbound"
      source_address_prefix  = "10.101.198.0/25"
      protocol               = "Tcp"
      destination_port_range = "*"
      access                 = "Allow"
      description            = "Allow traffic from non-deterministic network in FL.A1"
    },
    {
      name                   = "FL.A1.CO.PHC01"
      priority               = "404"
      direction              = "Inbound"
      source_address_prefix  = "10.101.192.0/26"
      protocol               = "Tcp"
      destination_port_range = "*"
      access                 = "Allow"
      description            = "Allow traffic from non-deterministic network in FL.A1"
    },
    {
      name                   = "FL.C1_Range_1"
      priority               = "405"
      direction              = "Inbound"
      source_address_prefix  = "10.101.198.128/25"
      protocol               = "Tcp"
      destination_port_range = "*"
      access                 = "Allow"
      description            = "Allow traffic from non-deterministic network in FL.C1"
    },
    {
      name                   = "FL.C1_Range_2"
      priority               = "406"
      direction              = "Inbound"
      source_address_prefix  = "10.101.199.0/24"
      protocol               = "Tcp"
      destination_port_range = "*"
      access                 = "Allow"
      description            = "Allow traffic from non-deterministic network in FL.C1"
    },
  ]
}

