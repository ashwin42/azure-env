include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "rv" {
  config_path = "../recovery_vault"
}

dependency "subnet" {
  config_path = "../subnet"
}

locals {
  name = "F1S1-WWT-${basename(get_original_terragrunt_dir())}"
}

inputs = {
  vm_name                                = local.name
  enable_dns                             = true
  install_winrm                          = true
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_size                                = "Standard_D8as_v5"
  backup_vm                              = true
  ad_join_secrets_key_vault_name         = "nv-infra-core"
  ad_join_secrets_key_vault_rg           = "nv-infra-core"
  create_localadmin_password             = true
  localadmin_name                        = "nvadmin"
  storage_account_name                   = "nvprodbootdiagswc"
  ad_join                                = "true"
  storage_image_reference = {
    sku       = "win11-22h2-avd"
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-11"
    version   = "latest",
  }
  storage_os_disk = {
    create_option = "FromImage"
    caching       = "ReadWrite"
    disk_size_gb  = "512"
  }
  os_profile_windows_config = {
    enable_automatic_upgrades = true
    provision_vm_agent        = true
    timezone                  = "Central Europe Standard Time"
  }
  boot_diagnostics_enabled = true
  managed_disk_name        = "${local.name}-osdisk"
  custom_rules = [
    {
      name                  = "LocalSubnet"
      priority              = "201"
      direction             = "Inbound"
      source_address_prefix = values(dependency.subnet.outputs.subnets)[0].address_prefixes.0
      description           = "Allow connections from local subnet"
    },
    {
      name                  = "F1.U1.WC.UWL80.CM004.OT"
      priority              = "202"
      direction             = "Inbound"
      source_address_prefix = "10.203.91.64/26"
      description           = "Allow connections from F1.U1.WC.UWL80.CM004.OT"
    },
    {
      name                  = "F1.S1.DS.OT"
      priority              = "203"
      direction             = "Inbound"
      source_address_prefix = "10.202.128.0/24"
      description           = "Allow connections from F1.S1.DS.OT"
    },
    {
      name                  = "wwt_server01"
      priority              = "204"
      direction             = "Inbound"
      source_address_prefix = "10.14.16.145/32"
      description           = "Allow connections from wwt_server01"
    },
    {
      name                  = "wwt_server02"
      priority              = "205"
      direction             = "Inbound"
      source_address_prefix = "10.14.16.6/32"
      description           = "Allow connections from wwt_server02"
    },
    {
      name                  = "wwt_workstation"
      priority              = "206"
      direction             = "Inbound"
      source_address_prefix = "10.14.16.96/32"
      description           = "Allow connections from wwt_workstation"
    },
  ]
}

