terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.10.7"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
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
  netbox_role                            = "octoplant"
  name                                   = local.name
  vm_size                                = "Standard_D4_v3"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = true
  install_winrm                          = true
  managed_disk_size                      = 256
  storage_image_reference = {
    sku = include.root.locals.all_vars.windows_server_sku_2019,
  }
  os_profile_windows_config = {
    enable_automatic_upgrades = true
    provision_vm_agent        = true
  }
  os_profile = {
    admin_username = "nvadmin"
    computer_name  = local.name
  }
  data_disks = [
    {
      name                 = "${local.name}-datadisk01"
      size                 = "64"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
      caching              = "None"
    }
  ]
  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          private_ip_address            = "10.46.1.12"
          subnet_id                     = dependency.vnet.outputs.subnets["nv-octoplant-10.46.1.8_29"].id
          public_ip                     = false
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "ipconfig"
        },
      ]
    },
  ]
  custom_rules = [
    {
      name                    = "WWT_ETT-US1"
      priority                = "200"
      direction               = "Inbound"
      source_address_prefixes = ["10.14.16.96/32", "10.14.16.145/32", "10.14.16.6/32"]
      destination_port_range  = "64001-64023"
      access                  = "Allow"
      description             = "Allow connections from AWS Ett US1 WWT"
    },
  ]
}

