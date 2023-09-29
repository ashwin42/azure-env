terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.8.4"
  #source = "../../../../../../tf-mod-azure//vm/"
}

include {
  path = find_in_parent_folders()
}

dependency "vnet" {
  config_path = "../subnet"
}

dependency "wvd" {
  config_path = "../wvd"
}

dependency "rv" {
  config_path = "../recovery_vault"
}

locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  netbox_create_role                     = true
  netbox_role                            = "ums-viewlinc"
  token                                  = dependency.wvd.outputs.tokens.ums-env-wvd-hp
  host_pool_name                         = dependency.wvd.outputs.host_pools.ums-env-wvd-hp.name
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_name                                = local.name
  name                                   = local.name
  vm_size                                = "Standard_B4ms"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = true
  wvd_register                           = true
  install_winrm                          = true
  localadmin_key_name                    = "domainjoin"
  storage_image_reference = {
    sku = local.windows_server_sku,
  }
  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
  }
  os_profile = {
    admin_username = "domainjoin"
    computer_name  = local.name
  }
  move_default_rules = true
  network_interfaces = [
    {
      name    = "${local.name}-nic"
      primary = true
      ip_configuration = [
        {
          private_ip_address            = "10.46.0.148"
          subnet_id                     = dependency.vnet.outputs.subnet["ums-env-subnet-10.46.0.144_28"].id
          public_ip                     = false
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "ipconfig"
        },
      ]
    },
  ]
  custom_rules = [
    {
      name                    = "ETT_EMS_APs_TCP"
      priority                = "309"
      direction               = "Inbound"
      source_address_prefix   = "10.194.8.0/22"
      protocol                = "Tcp"
      destination_port_ranges = ["23", "80", "443", "502", "771", "950", "12500", "12600", "55000"]
      access                  = "Allow"
      description             = "Allow connections from Ett EMS Access points"
    },
    {
      name                    = "ETT_EMS_APs_UDP"
      priority                = "310"
      direction               = "Inbound"
      source_address_prefix   = "10.194.8.0/22"
      protocol                = "Udp"
      destination_port_ranges = ["6767", "12600"]
      access                  = "Allow"
      description             = "Allow connections from Ett EMS Access points"
    },
  ]
}

