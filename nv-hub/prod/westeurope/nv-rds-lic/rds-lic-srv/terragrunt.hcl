terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.9.4"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../../aadds/subnet"
}

dependency "rv" {
  config_path = "../recovery_vault"
}

locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  netbox_create_role                     = true
  netbox_role                            = "rds-lic"
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_name                                = local.name
  name                                   = local.name
  vm_size                                = "Standard_B2ms"
  backup_vm                              = true
  key_vault_name                         = "nv-hub-core"
  key_vault_rg                           = "nv-hub-core"
  create_localadmin_password             = true
  storage_account_name                   = "nvhubgeneralstorage"
  ad_join                                = true
  localadmin_key_name                    = "nv-rds-lic-nvadmin"
  install_winrm                          = true
  storage_image_reference = {
    sku = include.root.locals.all_vars.windows_server_sku_2019,
  }
  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
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
          private_ip_address            = "10.40.250.6"
          subnet_id                     = dependency.vnet.outputs.subnets["nv-domain-services"].id
          public_ip                     = false
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "${local.name}-nic-ipconfig"
        },
      ]
    },
  ]

  maintenance_configurations = [
    {
      name = "shared_services_tuesdays_0200_1"
    },
  ]

  custom_rules = [
    {
      name                   = "WMI_DCOM"
      priority               = "210"
      direction              = "Inbound"
      source_address_prefix  = "10.0.0.0/8"
      protocol               = "Tcp"
      destination_port_range = "135"
      access                 = "Allow"
      description            = "Allow connections for DCOM"
    },
    {
      name                   = "WMI_NP"
      priority               = "211"
      direction              = "Inbound"
      source_address_prefix  = "10.0.0.0/8"
      protocol               = "Tcp"
      destination_port_range = "445"
      access                 = "Allow"
      description            = "Allow connections for NP"
    },
    {
      name                   = "RPC"
      priority               = "212"
      direction              = "Inbound"
      source_address_prefix  = "10.0.0.0/8"
      protocol               = "Tcp"
      destination_port_range = "49152-65535"
      access                 = "Allow"
      description            = "Allow connections for RPC"
    },
  ]
  maintenance_configurations = [
    {
      name = "shared_services_tuesdays_0200_1"
    },
  ]
}

