terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.7.63"
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
  name = "labware"
}

inputs = {
  setup_prefix                           = "nv-${local.name}"
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  subnet_id                              = dependency.vnet.outputs.subnets.labx_subnet.id
  vm_name                                = local.name
  vm_size                                = "Standard_B2ms"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  localadmin_name                        = "nvadmin"
  localadmin_key_name                    = "nv-labx"
  storage_account_name                   = "nvinfrabootdiag"
  boot_diagnostics_enabled               = true
  ad_join                                = "true"
  managed_disk_name                      = "nv-labware-vm-osdisk"
  managed_disk_size                      = "64"
  storage_image_reference = {
    sku = "2019-Datacenter-smalldisk",
  }
  os_profile_windows_config = {
    provision_vm_agent         = true
    enable_automatic_upgrades  = true
    timezone                   = "W. Europe Standard Time"
    winrm                      = null
    additional_unattend_config = null
  }
  network_interfaces = [
    {
      name = "${local.name}-nic1"
      ip_configuration = [
        {
          ipaddress                     = "10.44.2.9"
          subnet_id                     = dependency.vnet.outputs.subnets.labx_subnet.id
          public_ip                     = false
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "${local.name}-nic1-ipconfig"
        },
      ]
    },
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
    }
  ]
}
