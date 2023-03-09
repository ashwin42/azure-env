terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.7.32"
  #source = "../../../../../../tf-mod-azure//vm/"
}

include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

dependency "wvd" {
  config_path = "../wvd-sipass"
}

locals {
  name = "siemensclient-0"
}

inputs = {
  token                                  = dependency.wvd.outputs.token
  host_pool_name                         = dependency.wvd.outputs.host_pool.name
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
  vm_name                                = local.name
  name                                   = local.name
  vm_size                                = "Standard_B8ms"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  storage_account_name                   = "nvinfrabootdiag"
  boot_diagnostics_enabled               = true
  ad_join                                = true
  wvd_register                           = true
  ad_join_extension_name                 = "joindomain"
  wvd_extension_name                     = "dscextension"
  localadmin_key_name                    = "domainjoin"
  managed_disk_name                      = "siemensclient-0_OsDisk_1_3aae4bb3c7954ad2a3f7beefa2edcf03"
  storage_image_reference = {
    offer     = "Windows-10",
    publisher = "MicrosoftWindowsDesktop",
    sku       = "19h2-evd",
  }
  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
  }
  os_profile = {
    admin_username = "domainjoin"
    computer_name  = local.name
  }
  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          ipaddress                     = "10.44.1.101"
          subnet_id                     = dependency.global.outputs.subnet.siemens_sipass_controllers.id
          public_ip                     = false
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "ipconfig"
        },
      ]
    },
  ]
  custom_rules = [
    {
      name                   = "Labs_MFA_VPN"
      priority               = "200"
      direction              = "Inbound"
      source_address_prefix  = "10.16.8.0/23"
      protocol               = "*"
      destination_port_range = "0-65535"
      access                 = "Allow"
      description            = "Allow connections from Labs MFA VPN clients"
    },
    {
      name                   = "LocalVnet"
      priority               = "205"
      direction              = "Inbound"
      source_address_prefix  = dependency.global.outputs.virtual_network.address_space[0]
      protocol               = "Tcp"
      destination_port_range = 8742
      access                 = "Allow"
      description            = "Allow connections from local VNet"
    },
    {
      name                   = "Cellhouse"
      priority               = "207"
      direction              = "Inbound"
      source_address_prefix  = "10.193.8.0/24"
      protocol               = "*"
      destination_port_range = "0-65535"
      access                 = "Allow"
      description            = "Allow connections from Cellhouse"
    },
  ]
  
  iam_assignments = {
    "Virtual Machine Contributor" = {
      groups = [
        "Physical Security Server Administrators",
      ],
    },
  }
}

