terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.8.0"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm"
}

include {
  path = find_in_parent_folders()
}

dependency "vnet" {
  config_path = "../vnet"
}

dependency "rv" {
  config_path = "../recovery_vault"
}

dependency "as" {
  config_path = "../availability_sets"
}

locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  netbox_role                            = "desigo"
  vm_name                                = local.name
  name                                   = local.name
  vm_size                                = "Standard_D4s_v3"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = true
  localadmin_key_name                    = "domainjoin"
  managed_disk_name                      = "${local.name}-os"
  managed_disk_type                      = "Premium_LRS"
  availability_set_id                    = dependency.as.outputs.availability_sets.nv_siemens_avs

  storage_image_reference = {
    offer     = "WindowsServer",
    publisher = "MicrosoftWindowsServer",
    sku       = "2016-Datacenter",
  }

  os_profile_windows_config = {
    enable_automatic_upgrades = false
    provision_vm_agent        = true
    timezone                  = "W. Europe Standard Time"
  }

  os_profile = {
    admin_username = "nvadmin"
    computer_name  = local.name
  }

  identity = {
    type = "SystemAssigned"
  }

  network_security_groups = [
    {
      name               = "desigo-nsg"
      move_default_rules = true
      rules = [
        {
          name                    = "LocalVnet"
          priority                = "205"
          direction               = "Inbound"
          source_address_prefix   = dependency.vnet.outputs.virtual_network.address_space[0]
          source_port_ranges      = ["0-65535"]
          destination_port_ranges = ["0-65535"]
          access                  = "Allow"
          description             = "Allow connections from local VNet"
        },
        {
          name                    = "Temp_A_subnet"
          priority                = "206"
          direction               = "Inbound"
          source_address_prefix   = "10.0.0.0/8"
          source_port_ranges      = ["0-65535"]
          destination_port_ranges = ["0-65535"]
          access                  = "Allow"
          description             = "Allow connections from on-prem"
        },
        {
          name                    = "Cellhouse"
          priority                = "207"
          direction               = "Inbound"
          source_address_prefix   = "10.193.8.0/24"
          source_port_ranges      = ["0-65535"]
          destination_port_ranges = ["0-65535"]
          access                  = "Allow"
          description             = "Allow connections from Cellhouse"
        },
      ]
    },
  ]

  network_interfaces = [
    {
      name                = "${local.name}-nic"
      security_group_name = "desigo-nsg"
      primary             = true
      ip_configuration = [
        {
          private_ip_address            = "10.44.1.135"
          subnet_id                     = dependency.vnet.outputs.subnets.siemens_system_subnet.id
          ipconfig_name                 = "${local.name}-nic_config"
          private_ip_address_allocation = "Static"
        },
      ]
    },
    {
      name                = "${local.name}-second-nic"
      security_group_name = "desigo-nsg"
      ip_configuration = [
        {
          private_ip_address            = "10.44.1.40"
          subnet_id                     = dependency.vnet.outputs.subnets.siemens_cameras.id
          ipconfig_name                 = "${local.name}-second-nic_config"
          private_ip_address_allocation = "Static"
        },
      ]
    },
  ]

  data_disks = [
    {
      name                 = "${local.name}-data1"
      size                 = "1024"
      lun                  = "5"
      storage_account_type = "Premium_LRS"
    }
  ]
}

