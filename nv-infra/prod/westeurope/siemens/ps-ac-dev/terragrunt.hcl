terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.7.59"
  #source = "../../../../../../tf-mod-azure//vm/netbox"
}

include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

locals {
  name            = basename(get_terragrunt_dir())
  localadmin_name = "nvadmin"
}

inputs = {
  netbox_role                            = "desigo"
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
  vm_name                                = local.name
  name                                   = local.name
  vm_size                                = "Standard_B8ms"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  localadmin_name                        = local.localadmin_name
  localadmin_key_name                    = "${local.name}-${local.localadmin_name}"
  create_localadmin_password             = true
  storage_account_name                   = "nvinfrabootdiag"
  boot_diagnostics_enabled               = true
  ad_join                                = true
  storage_image_reference = {
    offer     = "WindowsServer",
    publisher = "MicrosoftWindowsServer",
    sku       = "2019-Datacenter",
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
          private_ip_address            = "10.44.1.143"
          subnet_id                     = dependency.global.outputs.subnet.siemens_system_subnet.id
          public_ip                     = false
          ipconfig_name                 = "${local.name}-nic_config"
          private_ip_address_allocation = "Static"
        },
      ]
    },
  ]
  data_disks = [
    {
      name                 = "${local.name}-data1"
      size                 = "300"
      lun                  = "5"
      storage_account_type = "Standard_LRS"
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
      source_address_prefix  = dependency.global.outputs.virtual_network.address_space[0]
      protocol               = "*"
      destination_port_range = "0-65535"
      access                 = "Allow"
      description            = "Allow connections from local VNet"
    },
    {
      name                   = "LocalVnet_RDP"
      priority               = "206"
      direction              = "Inbound"
      source_address_prefix  = dependency.global.outputs.virtual_network.address_space[0]
      protocol               = "Tcp"
      destination_port_range = "3389"
      access                 = "Allow"
      description            = "Allow RDP connections from local VNet"
    },
    {
      name                   = "Cellhouse"
      priority               = "207"
      direction              = "Inbound"
      source_address_prefix  = "10.193.8.0/24"
      protocol               = "*"
      destination_port_range = "0-65535"
      access                 = "Allow"
      description            = "Allow connections from Cellhouse"
    },
    {
      name                   = "Temp_A_subnet"
      priority               = "208"
      direction              = "Inbound"
      source_address_prefix  = "10.0.0.0/8"
      protocol               = "*"
      destination_port_range = "0-65535"
      access                 = "Allow"
      description            = "Allow connections from on-prem"
    },

  ]
}

