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
  name    = basename(get_original_terragrunt_dir())
  vm_name = "veeam${local.name}"
}

inputs = {
  vm_name                                = local.vm_name
  ad_join_secrets_key_vault_name         = "nv-infra-core"
  ad_join_secrets_key_vault_rg           = "nv-infra-core"
  ad_join                                = true
  backup_vm                              = true
  boot_diagnostics_enabled               = true
  create_localadmin_password             = true
  localadmin_name                        = "${local.vm_name}-nvadmin"
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  secrets_key_vault_name                 = "nv-infra-core"
  secrets_key_vault_rg                   = "nv-infra-core"
  storage_account_name                   = "nvinfrabootdiag"
  vm_size                                = "Standard_D4_v3"
  install_winrm                          = true
  storage_image_reference = {
    sku = "2022-Datacenter-smalldisk",
  }
  os_profile_windows_config = {
    timezone           = "W. Europe Standard Time"
    provision_vm_agent = true
  }
  data_disks = [
    {
      name                 = "${local.vm_name}-data1"
      size                 = "80"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
    },
  ]
}

