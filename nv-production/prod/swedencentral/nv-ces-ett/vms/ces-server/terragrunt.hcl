terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.8.2"
  #source = "../../../../../../tf-mod-azure//vm/"
}

include {
  path = find_in_parent_folders()
}

dependency "vnet" {
  config_path = "../../subnet"
}

dependency "rv" {
  config_path = "../../recovery_vault"
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
  vm_size                                = "Standard_D8as_v5"
  backup_vm                              = true
  key_vault_name                         = "nv-production-core"
  key_vault_rg                           = "nv-production-core"
  storage_account_name                   = "nvprodbootdiagswc"
  boot_diagnostics_enabled               = true
  create_localadmin_password             = true
  ad_join                                = true
  managed_disk_size                      = 127
  identity = {
    type         = "SystemAssigned"
    identity_ids = null
  }
  storage_image_reference = {
    offer     = include.root.locals.all_vars.windows_server_offer,
    publisher = include.root.locals.all_vars.local.windows_server_publisher,
    sku       = "2022-datacenter-g2",
  }
  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
    timezone                  = "Central Europe Standard Time"
  }
  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          private_ip_address            = "10.64.1.196"
          subnet_id                     = dependency.vnet.outputs.subnet["nv-ces-ett-subnet-10.64.1.192_28"].id
          public_ip                     = false
          private_ip_address_allocation = "Static"
        },
      ]
    },
  ]
  network_security_groups = [
    {
      name               = "desigo-nsg"
      move_default_rules = true
      rules = [
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
          name                   = "Ett_MFA_VPN"
          priority               = "201"
          direction              = "Inbound"
          source_address_prefix  = "10.240.0.0/21"
          protocol               = "*"
          destination_port_range = "0-65535"
          access                 = "Allow"
          description            = "Allow connections from Ett MFA VPN clients"
        },
        {
          name                   = "Ett_CES_Clients_https"
          priority               = "203"
          direction              = "Inbound"
          source_address_prefix  = "10.194.32.0/22"
          protocol               = "Tcp"
          destination_port_range = "7899"
          access                 = "Allow"
          description            = "Allow https connections from Ett airius devices"
        },
        {
          name                   = "Ett_CES_Clients_http"
          priority               = "204"
          direction              = "Inbound"
          source_address_prefix  = "10.194.32.0/22"
          protocol               = "Tcp"
          destination_port_range = "7890"
          access                 = "Allow"
          description            = "Allow http connections from Ett airius devices"
        },
        {
          name                  = "LocalSubnet"
          priority              = "205"
          direction             = "Inbound"
          source_address_prefix = dependency.vnet.outputs.subnet["nv-ces-ett-subnet-10.64.1.192_28"].address_prefixes.0
          access                = "Allow"
          description           = "Allow connections from local subnet"
        }
      ]
    }
  ]
}

