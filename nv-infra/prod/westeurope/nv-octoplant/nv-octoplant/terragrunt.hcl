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
  vm_size                                = "Standard_D4_v3"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = true
  #localadmin_key_name                    = "domainjoin"
  storage_image_reference = {
    sku = "2019-Datacenter",
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
          ipaddress                     = "10.46.1.12"
          subnet_id                     = dependency.vnet.outputs.subnet["nv-octoplant-10.46.1.8_29"].id
          public_ip                     = false
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "ipconfig"
        },
      ]
    },
  ]
  custom_rules = [
    {
      name                   = "Labs_RDP_MFA_VPN"
      priority               = "200"
      direction              = "Inbound"
      source_address_prefix  = "10.16.8.0/23"
      protocol               = "Tcp"
      destination_port_range = "0-65535"
      access                 = "Allow"
      description            = "Allow RDP connections from Labs MFA VPN clients"
    },
    {
      name                   = "Ett_MFA_VPN"
      priority               = "201"
      direction              = "Inbound"
      source_address_prefix  = "10.240.0.0/21"
      protocol               = "*"
      destination_port_range = "0-65535"
      access                 = "Allow"
      description            = "Allow connections from Ett MFA VPN clients"
    }, 
  ]
}

