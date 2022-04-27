terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.2.28"
  #source = "../../../../../../tf-mod-azure//vm/"
}

include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
  vm_name                                = local.name
  name                                   = local.name
  vm_size                                = "Standard_B4ms"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = true
  localadmin_key_name                    = "${local.name}-nvadmin"
  managed_disk_type                      = "Premium_LRS"
  storage_image_reference = {
    offer     = "sql2019-ws2022",
    publisher = "MicrosoftSQLServer",
    sku       = "Standard",
  }
  os_profile_windows_config = {
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
          private_ip_address            = "10.44.1.142"
          subnet_id                     = dependency.global.outputs.subnet.siemens_system_subnet.id
          ipconfig_name                 = "${local.name}-nic_config"
          private_ip_address_allocation = "Static"
        },
      ]
    },
  ]
  data_disks = [
    {
      name                 = "${local.name}-data1"
      size                 = "500"
      lun                  = "5"
      storage_account_type = "Premium_LRS"
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
      name                   = "LocalVnet"
      priority               = "205"
      direction              = "Inbound"
      source_address_prefix  = dependency.global.outputs.virtual_network.address_space[0]
      protocol               = "TCP"
      destination_port_range = "1433,3389"
      access                 = "Allow"
      description            = "Allow connections from local VNet"
    },
    {
      name                   = "LocalVnetSQL-UDP"
      priority               = "206"
      direction              = "Inbound"
      source_address_prefix  = dependency.global.outputs.virtual_network.address_space[0]
      protocol               = "UDP"
      destination_port_range = 1434
      access                 = "Allow"
      description            = "Allow connections from local VNet"
    },
    {
      name                   = "LocalVnetAll"
      priority               = "207"
      direction              = "Inbound"
      source_address_prefix  = dependency.global.outputs.virtual_network.address_space[0]
      protocol               = "*"
      destination_port_range = "0-65535"
      access                 = "Allow"
      description            = "Allow connections from local VNet"
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
  ]
}
