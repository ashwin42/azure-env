terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.7.56"
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
  name                                   = local.name
  vm_size                                = "Standard_D8s_v5"
  backup_vm                              = true
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  localadmin_key_name                    = "${local.name}-nvadmin"
  create_localadmin_password             = true
  managed_disk_name                      = "${local.name}-os"
  managed_disk_type                      = "StandardSSD_LRS"
  storage_image_reference = {
    offer     = "WindowsServer",
    publisher = "MicrosoftWindowsServer",
    sku       = "2022-Datacenter",
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
          private_ip_address            = "10.44.1.144"
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
      size                 = "1024"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
    }
  ]
  custom_rules = [
    {
      name                  = "Labs_MFA_VPN"
      priority              = "200"
      direction             = "Inbound"
      source_address_prefix = "10.16.8.0/23"
      protocol              = "Tcp"
      access                = "Allow"
      description           = "Allow connections from Labs MFA VPN clients"
    },
    {
      name                   = "Ett_MFA_VPN"
      priority               = "210"
      direction              = "Inbound"
      source_address_prefix  = "10.240.0.0/21"
      protocol               = "Tcp"
      destination_port_range = "0-65535"
      access                 = "Allow"
      description            = "Allow connections from Ett MFA VPN clients"
    },
    {
      name                  = "LocalVnet"
      priority              = "205"
      direction             = "Inbound"
      source_address_prefix = dependency.global.outputs.virtual_network.address_space[0]
      access                = "Allow"
      description           = "Allow connections from local VNet"
    },
  ]
}

