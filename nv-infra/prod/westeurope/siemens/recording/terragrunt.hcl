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

dependency "as" {
  config_path = "../availability_sets"
}

locals {
  name = "recordingserver"
}

inputs = {
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
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
    timezone                  = "W. Europe Standard Time"
  }
  os_profile = {
    admin_username = "nvadmin"
    computer_name  = local.name
  }
  network_interfaces = [
    {
      name    = "${local.name}-nic"
      primary = true
      ip_configuration = [
        {
          ipaddress                     = "10.44.1.139"
          subnet_id                     = dependency.global.outputs.subnet.siemens_system_subnet.id
          ipconfig_name                 = "${local.name}-nic_config"
          private_ip_address_allocation = "Static"
        },
      ]
    },
    {
      name    = "recording-second-nic"
      primary = false
      ip_configuration = [
        {
          ipaddress                     = "10.44.1.44"
          subnet_id                     = dependency.global.outputs.subnet.siemens_cameras.id
          ipconfig_name                 = "recording-second-nic_config"
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
      name                  = "Labs_MFA_VPN"
      priority              = "200"
      direction             = "Inbound"
      source_address_prefix = "10.16.8.0/23"
      access                = "Allow"
      description           = "Allow connections from Labs MFA VPN clients"
    },
    {
      name                  = "LocalVnet"
      priority              = "205"
      direction             = "Inbound"
      source_address_prefix = dependency.global.outputs.virtual_network.address_space[0]
      access                = "Allow"
      description           = "Allow connections from local VNet"
    },
    {
      name                  = "Temp_A_subnet"
      priority              = "206"
      direction             = "Inbound"
      source_address_prefix = "10.0.0.0/8"
      access                = "Allow"
      description           = "Allow connections from on-prem"
    },
  ]
}

