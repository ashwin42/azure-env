terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.8.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm/"
}

include {
  path = find_in_parent_folders()
}

dependency "vnet" {
  config_path = "../../subnet"
}

dependency "wvd" {
  config_path = "../../wvd"
}

dependency "rv" {
  config_path = "../../recovery_vault"
}

locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  token                                  = dependency.wvd.outputs.token
  host_pool_name                         = dependency.wvd.outputs.host_pool.name
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_name                                = local.name
  name                                   = local.name
  vm_size                                = "Standard_B8ms"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = true
  wvd_register                           = true
  localadmin_key_name                    = "domainjoin"
  netbox_create_role                     = true
  netbox_role                            = "apisiq"

  storage_image_reference = {
    offer     = "Windows-10",
    publisher = "MicrosoftWindowsDesktop",
    sku       = "21h1-evd-g2",
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
      name                = "${local.name}-nic"
      security_group_name = "apis-iq-nsg"
      ip_configuration = [
        {
          private_ip_address            = "10.46.1.52"
          subnet_id                     = dependency.vnet.outputs.subnets["nv-apis-iq-subnet-10.46.1.48_28"].id
          public_ip                     = false
          private_ip_address_allocation = "Dynamic"
          ipconfig_name                 = "ipconfig"
        },
      ]
    },
  ]

  network_security_groups = [
    {
      name               = "apis-iq-nsg"
      move_default_rules = true
      rules = [
        {
          name                    = "Labs_MFA_VPN"
          priority                = "200"
          direction               = "Inbound"
          source_address_prefix   = "10.16.8.0/23"
          protocol                = "*"
          destination_port_ranges = ["0-65535"]
          access                  = "Allow"
          description             = "Allow connections from Labs MFA VPN clients"
        },
      ]
    }
  ]
}

