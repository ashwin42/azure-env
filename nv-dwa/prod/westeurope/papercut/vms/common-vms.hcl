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

dependency "avd" {
  config_path = "../avd/001"
}

locals {
  name    = "${basename(dirname(get_terragrunt_dir()))}${basename(get_original_terragrunt_dir())}"
  vm_name = local.name
}

inputs = {
  wvd_register                           = true
  token                                  = values(dependency.avd.outputs.tokens)[0]
  host_pool_name                         = keys(dependency.avd.outputs.host_pools)[0]
  netbox_role                            = "dwa-papercut"
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
  create_localadmin_password             = true
  localadmin_name                        = "nvadmin"
  storage_account_name                   = dependency.storage.outputs.storage_account_name
  aad_join                               = true
  mdm_register                           = true
  dns_zone                               = "dwa.nvlt.net"
  storage_image_reference = {
    sku       = "win11-22h2-avd"
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-11"
    version   = "latest",
  }
  storage_os_disk = {
    create_option = "FromImage"
    caching       = "ReadWrite"
    disk_size_gb  = "256"
  }
  identity = {
    type = "SystemAssigned"
  }
  os_profile_windows_config = {
    enable_automatic_upgrades = true
    provision_vm_agent        = true
    timezone                  = "Central Europe Standard Time"
  }
  boot_diagnostics_enabled = true
  managed_disk_name        = "${local.vm_name}-osdisk"
  custom_rules = [
    {
      name                  = "LocalSubnet"
      priority              = "201"
      direction             = "Inbound"
      source_address_prefix = dependency.subnet.outputs.subnets["papercut-subnet1"].address_prefixes[0]
      description           = "Allow connections from local subnet"
    },
    {
      name                   = "dwa_printer_mgmt_wvd"
      priority               = "202"
      direction              = "Inbound"
      source_address_prefix  = "10.17.16.0/20"
      protocol               = "Tcp"
      destination_port_range = "3389"
      access                 = "Allow"
      description            = "Allow connections from Dwa office subnet"
    }
  ]
  iam_assignments = {
    "Virtual Machine Administrator Login" = {
      groups = [
        "NV TechOps Role",
        "NV IT Core Role",
        "Printing Management System (Papercut) for Poland entity - Admin - Production",
      ],
    },
  }
}

