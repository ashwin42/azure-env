terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.9.4"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../../subnet"
}

dependency "rv" {
  config_path = "../../recovery_vault"
}

locals {
  name = "octoplant-dwa${basename(get_original_terragrunt_dir())}"
}

inputs = {
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_name                                = local.name
  vm_size                                = "Standard_D4_v3"
  storage_account_name                   = "nvdwainfrabootdiag"
  boot_diagnostics_enabled               = true
  backup_vm                              = true
  ad_join                                = true
  create_localadmin_password             = true
  install_winrm                          = true
  netbox_role                            = "octoplant"
  netbox_tags                            = ["monitoring:windows_node_exporter"]
  managed_disk_size                      = 256
  storage_image_reference = {
    sku = include.root.locals.all_vars.windows_server_sku_2019,
  }
  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = false
    timezone                  = "W. Europe Standard Time"
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
          private_ip_address            = "10.46.97.5"
          subnet_id                     = dependency.vnet.outputs.subnets["octoplant-dwa-10.46.97.0_29"].id
          public_ip                     = false
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "ipconfig"
        },
      ]
    },
  ]
  data_disks = [
    {
      name                 = "${local.name}-datadisk01"
      size                 = "256"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
      caching              = "None"
    }
  ]
  custom_rules = [
    {
      name                   = "Dwa_VPN_80"
      priority               = "200"
      direction              = "Inbound"
      source_address_prefix  = "10.240.32.0/23"
      protocol               = "*"
      destination_port_range = "80"
      access                 = "Allow"
      description            = "Allow connections from Dwa VPN clients on port 80"
    },
    {
      name                   = "Dwa_VPN_443"
      priority               = "201"
      direction              = "Inbound"
      source_address_prefix  = "10.240.32.0/23"
      protocol               = "*"
      destination_port_range = "443"
      access                 = "Allow"
      description            = "Allow connections from Dwa VPN clients on port 443"
    },
    {
      name                   = "Dwa_VPN_64021"
      priority               = "204"
      direction              = "Inbound"
      source_address_prefix  = "10.240.32.0/23"
      protocol               = "*"
      destination_port_range = "64021"
      access                 = "Allow"
      description            = "Allow connections from Dwa VPN clients on port 64021"
    },
    {
      name                   = "Dwa_VPN_64023"
      priority               = "205"
      direction              = "Inbound"
      source_address_prefix  = "10.240.32.0/23"
      protocol               = "*"
      destination_port_range = "64023"
      access                 = "Allow"
      description            = "Allow connections from Dwa VPN clients"
    },
    {
      name                   = "Dwa_VPN_64001-64004"
      priority               = "206"
      direction              = "Inbound"
      source_address_prefix  = "10.240.32.0/23"
      protocol               = "*"
      destination_port_range = "64001-64004"
      access                 = "Allow"
      description            = "Allow connections from Dwa VPN clients on ports 64001-64004"
    },
    {
      name                   = "Dwa_VPN_64006"
      priority               = "207"
      direction              = "Inbound"
      source_address_prefix  = "10.240.32.0/23"
      protocol               = "*"
      destination_port_range = "64006"
      access                 = "Allow"
      description            = "Allow connections from Dwa VPN clients on port 64006"
    },
  ]
}

