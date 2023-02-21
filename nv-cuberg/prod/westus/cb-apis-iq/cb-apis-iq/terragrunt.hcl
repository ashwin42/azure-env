terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.7.35"
  #source = "${dirname(get_repo_root())}//tf-mod-azure//vm/"
}

include {
  path = find_in_parent_folders()
}

dependency "vnet" {
  config_path = "../../global/vnet"
}

dependency "avd" {
  config_path = "../avd"
}

dependency "rv" {
  config_path = "../../global/recovery_vault/"
}

locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  name                                   = "westus2.nv-cuberg.apis-iq-vm"
  vm_size                                = "Standard_B4ms"
  backup_vm                              = true
  key_vault_rg                           = "global-rg"
  key_vault_name                         = "nvcuberginfrasecrets"
  storage_account_name                   = "nvcuberginfrabootdiag"
  aad_join                               = true
  wvd_register                           = true
  mdm_register                           = true
  token                                  = dependency.avd.outputs.tokens["westus2-nv-cuberg-apis-iq-hp"]
  host_pool_name                         = "westus2-nv-cuberg-apis-iq-hp"
  localadmin_key_name                    = "${local.name}-nvadmin"
  create_localadmin_password             = true
  
  storage_image_reference = {
    offer     = "Windows-10",
    publisher = "MicrosoftWindowsDesktop",
    sku       = "21h1-evd-g2",
    version   = "latest"
  }
  
  os_profile_windows_config = {
    provision_vm_agent         = true
    enable_automatic_upgrades  = true
    timezone                   = "Pacific Standard Time"
  }
  
  os_profile = {
    admin_username = "nvadmin"
    computer_name  = local.name
  }

  identity = {
    type = "SystemAssigned"
  }
  
  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          ipaddress                     = "10.66.0.4"
          subnet_id                     = dependency.vnet.outputs.subnets["westus2.nv-cuberg.general-subnet"].id
          public_ip                     = false
          private_ip_address_allocation = "Dynamic"
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
  ]

  iam_assignments = {
    "Virtual Machine Administrator Login" = {
      groups = [
        "NV TechOps Role",
      ],
    },
    "Virtual Machine User Login" = {
      groups = [
        "Cuberg APIS IQ User Access"
      ],
    },
  }
}

