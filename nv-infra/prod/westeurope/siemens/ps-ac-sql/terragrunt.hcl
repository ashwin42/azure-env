terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.8.0"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../vnet"
}

dependency "rv" {
  config_path = "../recovery_vault"
}

locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
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
    provision_vm_agent        = true
    timezone                  = "W. Europe Standard Time"
  }

  os_profile = {
    admin_username = "nvadmin"
    computer_name  = local.name
  }

  network_security_groups = [
    {
      name               = "ps-ac-sql-nsg"
      move_default_rules = true
      rules = [
        {
          name                    = "LocalVnet"
          priority                = "205"
          direction               = "Inbound"
          source_address_prefix   = dependency.vnet.outputs.virtual_network.address_space[0]
          protocol                = "Tcp"
          destination_port_ranges = ["1433", "3389"]
          access                  = "Allow"
          description             = "Allow connections from local VNet"
        },
        {
          name                   = "LocalVnetSQL-UDP"
          priority               = "206"
          direction              = "Inbound"
          source_address_prefix  = dependency.vnet.outputs.virtual_network.address_space[0]
          protocol               = "Udp"
          destination_port_range = 1434
          access                 = "Allow"
          description            = "Allow connections from local VNet"
        },
        {
          name                   = "LocalVnetAll"
          priority               = "207"
          direction              = "Inbound"
          source_address_prefix  = dependency.vnet.outputs.virtual_network.address_space[0]
          protocol               = "*"
          destination_port_range = "0-65535"
          access                 = "Allow"
          description            = "Allow connections from local VNet"
        },
      ],
    },
  ]

  network_interfaces = [
    {
      name                = "${local.name}-nic"
      security_group_name = "ps-ac-sql-nsg"
      ip_configuration = [
        {
          private_ip_address            = "10.44.1.142"
          subnet_id                     = dependency.vnet.outputs.subnets.siemens_system_subnet.id
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
}

