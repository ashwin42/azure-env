terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.5.0"
}

locals {
  name = "qc-ftp-server"
}

include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

inputs = {
  setup_prefix                           = dependency.global.outputs.setup_prefix
  name                                   = local.name
  vm_name                                = local.name
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
  vm_size                                = "Standard_B2s"
  managed_disk_name                      = "${local.name}-osdisk"
  managed_disk_type                      = "StandardSSD_LRS"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  localadmin_name                        = "nvadmin"
  localadmin_key_name                    = "${local.name}-nvadmin"
  storage_account_name                   = "nvinfrabootdiag"
  boot_diagnostics_enabled               = true
  storage_image_reference = {
    offer     = "0001-com-ubuntu-minimal-focal-daily",
    publisher = "Canonical",
    sku       = "minimal-20_04-daily-lts",
  }
  network_interfaces = [
    {
      name = "${local.name}-nic1"
      ip_configuration = [
        {
          ipaddress                     = "10.44.2.12"
          subnet_id                     = dependency.global.outputs.subnet.labx_subnet.id
          public_ip                     = false
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "${local.name}-nic1-ipconfig"
        },
      ]
    },
  ]
  custom_rules = [
    {
      name                  = "Labs_MFA_VPN"
      priority              = "200"
      direction             = "Inbound"
      source_address_prefix = "10.16.8.0/23"
      access                = "Allow"
      description           = "Allow connections from Labs MFA VPN clients"
    },
    {
      name                  = "Labs_QC_Lab"
      priority              = "210"
      direction             = "Inbound"
      source_address_prefix = "10.192.1.0/24"
      access                = "Allow"
      description           = "Allow connections from Labs QC Lab clients"
    },
  ]
}

