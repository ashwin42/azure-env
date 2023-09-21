terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.8.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../../subnet"
}

dependency "rv" {
  config_path = "../../recovery_vault"
}

dependency "wvd" {
  config_path = "../../wvd/01"
}

locals {
  name    = basename(get_terragrunt_dir())
  hp_name = "${include.root.inputs.setup_prefix}-01-hp"
  subnet  = "${include.root.inputs.setup_prefix}-subnet-10.64.1.192_28"
}

inputs = {
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  token                                  = dependency.wvd.outputs.tokens[local.hp_name]
  host_pool_name                         = local.hp_name
  name                                   = local.name
  vm_size                                = "Standard_D8as_v5"
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  backup_vm                              = true
  aad_join                               = true
  mdm_register                           = true
  wvd_register                           = true
  create_localadmin_password             = true

  storage_image_reference = {
    offer     = "Windows-11",
    publisher = "MicrosoftWindowsDesktop",
    sku       = "win11-22h2-avd",
    version   = "latest"
  }

  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
    timezone                  = "Central Europe Standard Time"
  }

  identity = {
    type = "SystemAssigned"
  }

  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          private_ip_address            = "10.64.1.199"
          subnet_id                     = dependency.vnet.outputs.subnet[local.subnet].id
          public_ip                     = false
          private_ip_address_allocation = "Static"
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
      name                  = "LocalSubnet"
      priority              = "205"
      direction             = "Inbound"
      source_address_prefix = dependency.vnet.outputs.subnet[local.subnet].address_prefixes.0
      access                = "Allow"
      description           = "Allow connections from local subnet"
    }
  ]

  iam_assignments = {
    "Virtual Machine Administrator Login" = {
      groups = [
        "NV TechOps Role",
      ],
    },
    "Virtual Machine User Login" = {
      groups = [
        "VPN Condmaster Servers Access AP",
      ],
    },
  }
}

