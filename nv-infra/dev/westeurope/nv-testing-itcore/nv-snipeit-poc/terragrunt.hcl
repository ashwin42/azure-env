terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.7.59"
}

locals {
  name = basename(get_terragrunt_dir())
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

inputs = {
  name                                   = local.name
  netbox_role                            = "snipe-it"
  netbox_create_role                     = true
  vm_name                                = local.name
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_size                                = "Standard_B2s"
  managed_disk_name                      = "${local.name}-osdisk"
  managed_disk_type                      = "StandardSSD_LRS"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  localadmin_name                        = "nvadmin"
  create_localadmin_password             = true
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
          private_ip_address            = "10.46.0.200"
          subnet_id                     = dependency.vnet.outputs.subnet["nv-test-itcore-subnet-10.46.0.192-254"].id
          public_ip                     = false
          private_ip_address_allocation = "Static"
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

