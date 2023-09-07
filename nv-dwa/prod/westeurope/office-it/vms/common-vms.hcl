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
  vm_name = "officeit${local.name}"
}

inputs = {
  netbox_role                            = "dwa-officeIT"
  vm_name                                = local.vm_name
  setup_prefix                           = include.root.locals.all_vars.project
  resource_group_name                    = include.root.locals.all_vars.resource_group_name
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_size                                = "Standard_B4s_v2"
  backup_vm                              = true
  secrets_key_vault_name                 = dependency.vault.outputs.azurerm_key_vault.name
  secrets_key_vault_rg                   = dependency.vault.outputs.azurerm_key_vault.resource_group_name
  ad_join_secrets_key_vault_name         = "nv-infra-core"
  ad_join_secrets_key_vault_rg           = "nv-infra-core"
  create_localadmin_password             = true
  localadmin_name                        = "dwa-${local.name}-nvadmin"
  storage_account_name                   = dependency.storage.outputs.storage_account_name
  ad_join                                = "true"
  storage_image_reference = {
    sku       = "win11-22h2-pro"
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-11"
    version   = "latest",
  }
  storage_os_disk = {
    create_option = "FromImage"
    caching       = "ReadWrite"
    disk_size_gb  = "150"
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
      size                 = "300"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
    }
  ]
  custom_rules = [
    {
      name                  = "LocalSubnet"
      priority              = "205"
      direction             = "Inbound"
      source_address_prefix = dependency.subnet.outputs.subnets["office-it-subnet1"].address_prefixes[0]
      description           = "Allow connections from local subnet"
    },
    {
      name                   = "dwa_printer_mgmt_wvd"
      priority               = "201"
      direction              = "Inbound"
      source_address_prefix  = "10.17.16.0/20"
      protocol               = "Tcp"
      destination_port_range = "3389"
      access                 = "Allow"
      description            = "Allow connections from Dwa office subnet"
    },
    {
      name                   = "dwa_printer_umango"
      priority               = "201"
      direction              = "Inbound"
      source_address_prefix  = "10.17.16.0/27"
      protocol               = "Tcp"
      destination_port_range = "389,445,443,50080,50081"
      access                 = "Allow"
      description            = "Allow connections from Dwa office subnet"
    },
    {
      name                   = "dwa_printer_papercut"
      priority               = "201"
      direction              = "Inbound"
      source_address_prefix  = "10.17.16.0/27"
      protocol               = "Tcp"
      destination_port_range = "9191,9192,9193,636"
      access                 = "Allow"
      description            = "Allow connections from Dwa office subnet"
    },
    {
      name                   = "dwa_printer_papercut"
      priority               = "201"
      direction              = "Inbound"
      source_address_prefix  = "10.17.16.0/27"
      protocol               = "Tcp"
      destination_port_range = "9191,9192,9193,636"
      access                 = "Allow"
      description            = "Allow connections from Dwa office subnet"
    },
    {
      name                   = "dwa_printer_princity"
      priority               = "201"
      direction              = "Inbound"
      source_address_prefix  = "10.17.16.0/27"
      protocol               = "Udp"
      destination_port_range = "161,162"
      access                 = "Allow"
      description            = "Allow connections from Dwa office subnet"
    },
  ]
}

