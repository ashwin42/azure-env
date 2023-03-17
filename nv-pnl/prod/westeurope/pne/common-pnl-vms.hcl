include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "rv" {
  config_path = "../global/recovery_vault"
}

locals {
  name = basename(get_original_terragrunt_dir())
  custom_rules = [
    {
      name                   = "Labs_MFA_VPN"
      priority               = "200"
      direction              = "Inbound"
      source_address_prefix  = include.root.locals.all_vars.vpn_subnet_labs
      protocol               = "*"
      destination_port_range = "3389, 8735, 9182"
      access                 = "Allow"
      description            = "Allow connections from Labs MFA VPN clients"
    },
    {
      name                   = "WinRM"
      priority               = "205"
      direction              = "Inbound"
      source_address_prefix  = include.root.locals.all_vars.vpn_subnet_labs
      protocol               = "Tcp"
      destination_port_range = "5986"
      access                 = "Allow"
      description            = "Allow connections from Labs MFA VPN clients for WinRM"
    },
    {
      name                   = "Windows_Node_Exporter_1"
      priority               = "206"
      direction              = "Inbound"
      source_address_prefix  = "10.15.17.192/26" # prometheus subnet
      protocol               = "Tcp"
      destination_port_range = "9182"
      access                 = "Allow"
      description            = "Allow connection from prometheus to node_exporter"
    },
    {
      name                   = "Windows_Node_Exporter_2"
      priority               = "207"
      direction              = "Inbound"
      source_address_prefix  = "10.15.18.0/25" # prometheus subnet
      protocol               = "Tcp"
      destination_port_range = "9182"
      access                 = "Allow"
      description            = "Allow connection from prometheus to node_exporter"
    },
  ]
}

inputs = {
  name                                   = local.name
  vm_name                                = local.name
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_size                                = "Standard_D8_v4"
  backup_vm                              = true
  key_vault_rg                           = "global-rg"
  secrets_key_vault_rg                   = "global-rg"
  key_vault_name                         = "nv-pnl-we-secrets"
  storage_account_name                   = "nvpnlbootdiag"
  ad_join                                = true
  wvd_register                           = true
  localadmin_key_name                    = "${local.name}-vm-localadmin"
  create_localadmin_password             = true
  boot_diagnostics_enabled               = true
  install_winrm                          = true

  storage_image_reference = {
    offer     = "Windows-10",
    publisher = "MicrosoftWindowsDesktop",
    sku       = "21h1-evd-g2",
  }

  os_profile = {
    admin_username = "nvadmin"
    computer_name  = local.name
  }

  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
    timezone                  = ""
  }
}
