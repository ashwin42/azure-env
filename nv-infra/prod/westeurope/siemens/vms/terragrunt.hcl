terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.9.6"
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

dependency "as" {
  config_path = "../availability_sets"
}

locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_name                                = local.name
  name                                   = local.name
  vm_size                                = "Standard_D8s_v3"
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
    offer     = "SQL2016SP1-WS2016",
    publisher = "MicrosoftSQLServer",
    sku       = "Enterprise",
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

  network_security_groups = [
    {
      name               = "${local.name}-nsg"
      move_default_rules = true
      rules = [
        {
          name                  = "LocalVnet"
          priority              = "205"
          direction             = "Inbound"
          source_address_prefix = dependency.vnet.outputs.virtual_network.address_space[0]
          access                = "Allow"
          description           = "Allow connections from local VNet"
        },
        {
          name                    = "On-prem_Cameras_TCP"
          priority                = "206"
          direction               = "Inbound"
          source_address_prefixes = ["10.191.0.0/16", "10.193.0.0/16"]
          protocol                = "Tcp"
          destination_port_ranges = [80, 443, 9000, 22333, 40010]
          access                  = "Allow"
          description             = "Allow TCP connections from on-prem cameras"
        },
        {
          name                    = "On-prem_Cameras_UDP"
          priority                = "207"
          direction               = "Inbound"
          source_address_prefixes = ["10.191.0.0/16", "10.193.0.0/16"]
          protocol                = "Udp"
          destination_port_ranges = [123, "49000-65535"]
          access                  = "Allow"
          description             = "Allow UDP connections from on-prem cameras"
        },
      ]
      network_watcher_flow_log = include.root.inputs.network_watcher_flow_log
    },
  ]

  network_interfaces = [
    {
      name                = "${local.name}-nic"
      primary             = true
      security_group_name = "vms-nsg"
      ip_configuration = [
        {
          private_ip_address            = "10.44.1.136"
          subnet_id                     = dependency.vnet.outputs.subnets.siemens_system_subnet.id
          ipconfig_name                 = "${local.name}-nic_config"
          private_ip_address_allocation = "Static"
        },
      ]
    },
    {
      name                = "${local.name}-second-nic"
      security_group_name = "vms-nsg"
      ip_configuration = [
        {
          private_ip_address            = "10.44.1.43"
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
      size                 = "500"
      lun                  = "5"
      storage_account_type = "Premium_LRS"
    }
  ]
}

