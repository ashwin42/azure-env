terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.5.0"
}

include {
  path = find_in_parent_folders()
}

dependency "vnet" {
  config_path = "../../vnet"
}

dependency "rv" {
  config_path = "../../recovery_vault"
}

locals {
  name = "labx2"
}

inputs = {
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  subnet_id                              = dependency.vnet.outputs.subnets.labx_subnet.id
  vm_name                                = local.name
  managed_disk_type                      = "StandardSSD_LRS"
  managed_disk_name                      = "${local.name}-os"
  nsg0_name_alt                          = "nv_labx2_nsg"
  create_avset                           = "true"
  avset_name                             = "nv_labx2_avs"
  vm_size                                = "Standard_B4ms"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  localadmin_name                        = "nvadmin"
  localadmin_key_name                    = "nv-labx"
  storage_account_name                   = "nvinfrabootdiag"
  boot_diagnostics_enabled               = true
  ad_join                                = "true"
  storage_image_reference = {
    sku = "2016-Datacenter",
  }
  os_profile_windows_config = {
    provision_vm_agent         = true
    enable_automatic_upgrades  = false
    timezone                   = "W. Europe Standard Time"
    winrm                      = null
    additional_unattend_config = null
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
          ipaddress                     = "10.44.2.8"
          subnet_id                     = dependency.vnet.outputs.subnets.labx_subnet.id
          public_ip                     = false
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "${local.name}-nic_config"
        },
      ]
    },
  ]
  data_disks = [
    {
      name                 = "labx2-data1"
      size                 = "25"
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
      name                  = "LocalSubnet"
      priority              = "205"
      direction             = "Inbound"
      source_address_prefix = dependency.vnet.outputs.subnets.labx_subnet.address_prefixes.0
      access                = "Allow"
      description           = "Allow connections from local subnet"
    },
    {
      name                  = "NV-VH_VPN"
      priority              = "210"
      direction             = "Inbound"
      source_address_prefix = "10.10.0.0/21"
      access                = "Allow"
      description           = "Allow connections from NV-VH"
    }
  ]
}
