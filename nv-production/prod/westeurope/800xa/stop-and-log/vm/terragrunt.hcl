terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.5.2"
  #source = "../../../../../../../tf-mod-azure//vm/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "global" {
  config_path = "../../global"
}

locals {
  name = "stop-and-log"
}

inputs = {
  name                                   = local.name
  vm_name                                = local.name
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name

  vm_size                    = "Standard_DS2_v2"
  backup_vm                  = true
  key_vault_name             = "nv-production-core"
  key_vault_rg               = "nv-production-core"
  secrets_key_vault_name     = "nv-production-core"
  secrets_key_vault_rg       = "nv-production-core"
  storage_account_name       = "800xadiag"
  ad_join                    = false
  localadmin_key_name        = "${local.name}-vm-localadmin"
  create_localadmin_password = true
  storage_image_reference = {
    sku = include.root.locals.all_vars.windows_server_sku,
  }

  os_profile = {
    admin_username = "nvadmin"
    computer_name  = local.name
  }
  data_disks = [
    {
      name                 = "${local.name}-data1"
      size                 = "200"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
    }
  ]
  os_profile_windows_config = {
    provision_vm_agent         = true
    enable_automatic_upgrades  = true
    timezone                   = null
    winrm                      = null
    additional_unattend_config = null
  }
  custom_rules = [
    {
      name                  = "Labs_MFA_VPN"
      source_address_prefix = "10.16.8.0/23"
      description           = "Allow connections from Labs MFA VPN clients"
      priority              = "200"
      direction             = "Inbound"
    },
    {
      name                  = "Ett_MFA_VPN"
      source_address_prefix = "10.240.0.0/21"
      description           = "Allow connections from Ett MFA VPN clients"
      priority              = "201"
      direction             = "Inbound"
    },
    {
      name                  = "Labs-800xa-1"
      source_address_prefix = "10.0.0.0/23"
      description           = "Allow connections from Labx-800xa"
      priority              = "210"
      direction             = "Inbound"
    },
    {
      name                  = "Labs-800xa-2"
      source_address_prefix = "10.0.2.0/24"
      description           = "Allow connections from Labx-800xa"
      priority              = "220"
      direction             = "Inbound"
    },
    {
      name                  = "Labs-800xa-3"
      source_address_prefix = "10.0.50.0/23"
      description           = "Allow connections from Labx-800xa"
      priority              = "230"
      direction             = "Inbound"
    },
    {
      name                  = "Labs-800xa-4"
      source_address_prefix = "10.101.64.0/24"
      description           = "Allow connections from Labx-800xa"
      priority              = "240"
      direction             = "Inbound"
    },
    {
      name                  = "Labs-800xa-5"
      source_address_prefix = "10.150.16.0/22"
      description           = "Allow connections from Labx-800xa"
      priority              = "250"
      direction             = "Inbound"
    },
    {
      name                  = "Labs-800xa-6"
      source_address_prefix = "10.151.16.0/22"
      description           = "Allow connections from Labx-800xa"
      priority              = "260"
      direction             = "Inbound"
    },
    {
      name                  = "Local-Subnet-1"
      source_address_prefix = dependency.global.outputs.subnet_1.address_prefix
      description           = "Allow connections from local network"
      priority              = "270"
      direction             = "Inbound"
    },
    {
      name                  = "Local-Subnet-2"
      source_address_prefix = dependency.global.outputs.subnet_2.address_prefix
      description           = "Allow connections from local network"
      priority              = "280"
      direction             = "Inbound"
    },
    {
      name                  = "Local-Subnet-3"
      source_address_prefix = dependency.global.outputs.subnet_3.address_prefix
      description           = "Allow connections from local network"
      priority              = "290"
      direction             = "Inbound"
    },
  ]
  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          private_ip_address            = "10.60.46.4"
          subnet_id                     = dependency.global.outputs.subnet_stop-and-log.id
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "ipconfig"
        }
      ]
    }
  ]
}

