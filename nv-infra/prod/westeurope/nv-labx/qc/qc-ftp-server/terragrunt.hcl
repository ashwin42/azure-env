terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.8.0"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm"
}

locals {
  name = "qc-ftp-server"
}

include {
  path = find_in_parent_folders()
}

dependency "vnet" {
  config_path = "../../vnet"
}

dependency "rv" {
  config_path = "../../recovery_vault"
}

inputs = {
  name                                   = local.name
  vm_name                                = local.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
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

  network_security_groups = [
    {
      name               = "qc-ftp-server-nsg"
      move_default_rules = true
      rules = [
        {
          name                  = "Labs_QC_Lab"
          priority              = "210"
          direction             = "Inbound"
          source_address_prefix = "10.192.1.0/24"
          access                = "Allow"
          description           = "Allow connections from Labs QC Lab clients"
        },
      ]
    },
  ]

  network_interfaces = [
    {
      name                = "${local.name}-nic1"
      security_group_name = "qc-ftp-server-nsg"
      ip_configuration = [
        {
          ipaddress                     = "10.44.2.12"
          subnet_id                     = dependency.vnet.outputs.subnets.labx_subnet.id
          public_ip                     = false
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "${local.name}-nic1-ipconfig"
        },
      ]
    },
  ]
}

