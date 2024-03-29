include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "rv" {
  config_path = "../../global/recovery_vault"
}

dependency "storage" {
  config_path = "../../global/storage"
}
dependency "vault" {
  config_path = "../../global/vaults/secrets"
}

dependency "subnet" {
  config_path = "../subnet"
}

locals {
  name    = basename(get_original_terragrunt_dir())
  vm_name = "wcs-${local.name}"
}

inputs = {
  netbox_role                            = "wcs"
  vm_name                                = local.vm_name
  setup_prefix                           = include.root.locals.all_vars.project
  resource_group_name                    = include.root.locals.all_vars.resource_group_name
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_size                                = "Standard_B2ms"
  backup_vm                              = true
  secrets_key_vault_name                 = dependency.vault.outputs.azurerm_key_vault.name
  secrets_key_vault_rg                   = dependency.vault.outputs.azurerm_key_vault.resource_group_name
  ad_join_secrets_key_vault_name         = "nv-infra-core"
  ad_join_secrets_key_vault_rg           = "nv-infra-core"
  create_localadmin_password             = true
  localadmin_name                        = "wcs-${local.name}-nvadmin"
  storage_account_name                   = dependency.storage.outputs.storage_account_name
  ad_join                                = "true"
  storage_image_reference = {
    sku = "2022-Datacenter-smalldisk",
  }
  storage_os_disk = {
    create_option = "FromImage"
    caching       = "ReadWrite"
    disk_size_gb  = "64"
  }
  os_profile_windows_config = {
    enable_automatic_upgrades = true
    provision_vm_agent        = true
    timezone                  = "W. Europe Standard Time"
  }
  boot_diagnostics_enabled = true
  managed_disk_name        = "${local.vm_name}-osdisk"
  data_disks = [
    {
      name                 = "${include.root.locals.all_vars.project}-${local.name}-data1"
      size                 = "20"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
    },
    {
      name                 = "${include.root.locals.all_vars.project}-${local.name}-data2"
      size                 = "40"
      lun                  = "6"
      storage_account_type = "StandardSSD_LRS"
    }
  ]
  custom_rules = [
    {
      name                  = "LocalSubnet"
      priority              = "205"
      direction             = "Inbound"
      source_address_prefix = dependency.subnet.outputs.subnets["siemens-wcs-subnet1"].address_prefixes[0]
      description           = "Allow connections from local subnet"
    },
    {
      name                   = "Siemens_mgmt_wvd"
      priority               = "201"
      direction              = "Inbound"
      source_address_prefix  = "10.46.2.96/29"
      protocol               = "Tcp"
      destination_port_range = "3389"
      access                 = "Allow"
      description            = "Allow connections from Siemens Mgmt subnet"
    },
    {
      name                   = "LocalSubnetInboundWebApp"
      priority               = "210"
      direction              = "Inbound"
      source_address_prefix  = dependency.subnet.outputs.subnets["siemens-wcs-web-app-inbound"].address_prefixes[0]
      protocol               = "Tcp"
      destination_port_range = "4711,5005"
      description            = "Allow connections from local web delegated subnet"
    },
    {
      name                   = "LocalSubnetOutboundWebApp"
      priority               = "211"
      direction              = "Inbound"
      source_address_prefix  = dependency.subnet.outputs.subnets["siemens-wcs-web-app-outbound"].address_prefixes[0]
      protocol               = "Tcp"
      destination_port_range = "4711,5006"
      description            = "Allow connections from local web delegated subnet"
    },
    {
      name                   = "DWACoreAWSAccountCIDR1"
      priority               = "220"
      direction              = "Inbound"
      source_address_prefix  = "10.18.67.0/24"
      protocol               = "Tcp"
      description            = "Allow connections from DWA-Core AWS Account"
      destination_port_range = "5000-5020"
    },
    {
      name                   = "DWACoreAWSAccountCIDR2"
      priority               = "221"
      direction              = "Inbound"
      source_address_prefix  = "10.18.68.0/23"
      protocol               = "Tcp"
      description            = "Allow connections from DWA-Core AWS Account"
      destination_port_range = "5000-5020"
    },
  ]
}

