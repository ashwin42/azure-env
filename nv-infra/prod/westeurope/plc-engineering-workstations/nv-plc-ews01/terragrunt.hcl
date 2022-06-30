terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.3.0"
  #source = "../../../../../../tf-mod-azure//vm/"
}

include {
  path = find_in_parent_folders()
}

dependency "vnet" {
  config_path = "../subnet"
}

dependency "rv" {
  config_path = "../recovery_vault"
}

locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_name                                = local.name
  name                                   = local.name
  vm_size                                = "Standard_D4_v4"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = true
  storage_image_reference = {
    offer     = "Windows-10",
    publisher = "MicrosoftWindowsDesktop",
    sku       = "21h1-evd-g2",
  }
  os_profile_windows_config = {
    provision_vm_agent         = true
    enable_automatic_upgrades  = true
    timezone                   = null
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
          ipaddress                     = "10.46.1.36"
          subnet_id                     = dependency.vnet.outputs.subnet["nv-plc-ews-10.46.1.32_28"].id
          public_ip                     = false
          private_ip_address_allocation = "Dynamic"
          ipconfig_name                 = "ipconfig"
        },
      ]
    },
  ]
  data_disks = [
    {
      name                 = "${local.name}_datadisk"
      size                 = "75"
      lun                  = "0"
      storage_account_type = "StandardSSD_LRS"
    }
  ]
  custom_rules = [
    {
      name                   = "Labs_RDP_MFA_VPN"
      priority               = "200"
      direction              = "Inbound"
      source_address_prefix  = "10.16.8.0/23"
      protocol               = "Tcp"
      destination_port_range = "3389"
      access                 = "Allow"
      description            = "Allow RDP connections from Labs MFA VPN clients"
    },
    {
      name                   = "octoplant-labs_Allow_64001-64006"
      priority               = "300"
      direction              = "Inbound"
      source_address_prefix  = "10.46.1.12/32"
      protocol               = "Tcp"
      destination_port_range = "64001-64006"
      access                 = "Allow"
      description            = "Allow neccessary ports 64001-64006 from octoplant-labs"
    },
    {
      name                   = "octoplant-labs_Allow_64021"
      priority               = "301"
      direction              = "Inbound"
      source_address_prefix  = "10.46.1.12/32"
      protocol               = "Tcp"
      destination_port_range = "64021"
      access                 = "Allow"
      description            = "Allow neccessary port 64021 from octoplant-labs"
    },        
  ]
}

