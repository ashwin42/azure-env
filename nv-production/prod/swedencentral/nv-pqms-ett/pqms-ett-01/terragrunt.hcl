terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.7.59"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "rv" {
  config_path = "../recovery_vault"
}

dependency "vnet" {
  config_path = "../subnet"
}

locals {
  name = basename(get_original_terragrunt_dir())
}

inputs = {
  netbox_role                            = "pqms"
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_name                                = local.name
  name                                   = local.name
  vm_size                                = "Standard_B4ms"
  create_avset                           = true
  backup_vm                              = true
  create_localadmin_password             = true
  storage_account_name                   = "nvprodbootdiagswc"
  boot_diagnostics_enabled               = true
  ad_join                                = true
  install_winrm                          = true
  managed_disk_size                      = 127
  localadmin_key_name                    = "nv-pqms-ett-nvadmin"
  storage_image_reference = {
    sku = include.root.locals.all_vars.windows_server_sku_2019
  }
  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
    timezone                  = "W. Europe Standard Time"
  }
  os_profile = {
    admin_username = "nv-pqms-ett-nvadmin"
  }
  data_disks = [
    {
      name                 = "${local.name}-datadisk1"
      size                 = "127"
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
          private_ip_address            = "10.64.1.149"
          subnet_id                     = dependency.vnet.outputs.subnets["pqms-subnet"].id
          public_ip                     = false
          private_ip_address_allocation = "Static"
        },
      ]
    },
  ]
  custom_rules = [
    {
      name                  = "Ett_FF_UDP_Telemetry"
      priority              = "400"
      direction             = "Inbound"
      protocol              = "Udp"
      source_address_prefix = "10.194.12.0/22"
      description           = "Allow connections from ETT Factory SDAccess - PQMS"
    },
    {
      name                    = "Prometheus_Blackbox_Exporter"
      priority                = "401"
      direction               = "Inbound"
      protocol                = "Tcp"
      source_address_prefixes = include.root.locals.all_vars.prometheus_cidr_blocks
      destination_port_range  = "443"
      description             = "Allow connections from it-prod eks"
    },
  ]
}

