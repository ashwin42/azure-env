terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.9.4"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "rv" {
  config_path = "../recovery_vault"
}

dependency "subnet" {
  config_path = "../subnet"
}

locals {
  name = basename(get_original_terragrunt_dir())
}

inputs = {
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_name                                = local.name
  name                                   = local.name
  vm_size                                = "Standard_B2ms"
  backup_vm                              = true
  create_localadmin_password             = true
  localadmin_key_name                    = "nv-moscura-nvadmin"
  storage_account_name                   = "nvprodbootdiagswc"
  boot_diagnostics_enabled               = true
  ad_join                                = true
  managed_disk_size                      = 127
  netbox_role                            = "moscura"
  storage_image_reference = {
    sku = include.root.locals.all_vars.windows_server_sku_2019
  }
  os_profile = {
    computer_name  = local.name
    admin_username = "nv-moscura-nvadmin"
  }
  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
    timezone                  = "W. Europe Standard Time"
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
          private_ip_address            = "10.64.1.140"
          subnet_id                     = dependency.subnet.outputs.subnets["moscura-subnet"].id
          public_ip                     = false
          private_ip_address_allocation = "Static"
        },
      ]
    },
  ]
}

