terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.2.15"
}

locals {
  name = "print-gw-server"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
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
  storage_image_reference = {
    offer     = "UbuntuServer",
    publisher = include.root.locals.all_vars.ubuntu_publisher,
    sku       = "18.04-LTS",
  }
  network_interfaces = [
    {
      name      = "${local.name}-nic1"
      ipaddress = "10.44.5.230"
      subnet    = dependency.global.outputs.subnet.print-gw-subnet.id
      public_ip = false
    }
  ],
  custom_rules = [
    {
      name                  = "Labs_MFA_VPN"
      priority              = "200"
      direction             = "Inbound"
      source_address_prefix = "10.16.8.0/23"
      access                = "Allow"
      description           = "Allow connections from Labs MFA VPN clients"
    },
  ]
}

