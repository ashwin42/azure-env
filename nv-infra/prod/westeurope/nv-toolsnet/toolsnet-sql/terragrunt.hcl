terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.7.8"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "rv" {
  config_path = "../recovery_vault"
}

dependency "rg" {
  config_path = "../resource_group"
}

dependency "subnet" {
  config_path = "../subnet"
}


locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.rg.outputs.resource_group_name
  vm_name                                = local.name
  name                                   = local.name
  vm_size                                = "Standard_B4ms"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  storage_account_name                   = "nvinfrabootdiag"
  create_localadmin_password             = true
  ad_join                                = true
  localadmin_key_name                    = "${local.name}-nvadmin"
  storage_image_reference = {
    offer     = "sql2019-ws2022",
    publisher = "MicrosoftSQLServer",
    sku       = "Standard",
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
          private_ip_address            = "10.46.1.22"
          subnet_id                     = dependency.subnet.outputs.subnet["nv-toolsnet-subnet-10.46.1.16_28"].id
          private_ip_address_allocation = "Static"
        },
      ]
    },
  ]
  data_disks = [
    {
      name                 = "${local.name}-data1"
      size                 = "128"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
    }
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
      name                   = "LocalVnet"
      priority               = "205"
      direction              = "Inbound"
      source_address_prefix  = dependency.subnet.outputs.subnet["nv-toolsnet-subnet-10.46.1.16_28"].address_prefixes[0]
      protocol               = "Tcp"
      destination_port_range = "1433,3389"
      access                 = "Allow"
      description            = "Allow connections from local VNet"
    },
    {
      name                   = "LocalVnetSQL-UDP"
      priority               = "206"
      direction              = "Inbound"
      source_address_prefix  = dependency.subnet.outputs.subnet["nv-toolsnet-subnet-10.46.1.16_28"].address_prefixes[0]
      protocol               = "Udp"
      destination_port_range = "1434"
      access                 = "Allow"
      description            = "Allow connections from local VNet"
    },
  ]
}