terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.7.7"
}

include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

dependency "wvd" {
  config_path = "../wvd-tc10b"
}

locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  setup_prefix                           = dependency.global.outputs.setup_prefix
  token                                  = dependency.wvd.outputs.token
  host_pool_name                         = dependency.wvd.outputs.host_pool.name
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
  name                                   = local.name
  vm_name                                = local.name
  vm_size                                = "Standard_DS4_v2"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  storage_account_name                   = "nvinfrabootdiag"
  boot_diagnostics_enabled               = true
  ad_join                                = true
  wvd_register                           = true
  storage_image_reference = {
    offer     = "Windows-10",
    publisher = "MicrosoftWindowsDesktop",
    sku       = "21h1-evd-g2",
  }
  os_profile_windows_config = {
    provision_vm_agent         = true
    enable_automatic_upgrades  = true
    timezone                   = "W. Europe Standard Time"
  }
  os_profile = {
    admin_username = "domainjoin"
  }
  network_interfaces = [
    {
      name      = "${local.name}-nic"
      ip_configuration = [
        {
        ipaddress                     = "10.44.5.43"
        subnet_id                     = dependency.global.outputs.subnet["nv-pne-subnet-10.44.5.32"].id
        public_ip                     = false
        private_ip_address_allocation = "Static"
        ipconfig_name                 = "nv-pne-tc10b-nic-ipconfig"
        }
      ]
    }
  ]
  data_disks = [
    {
      name                 = "${local.name}_datadisk"
      size                 = "1000"
      lun                  = "0"
      storage_account_type = "StandardSSD_LRS"
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
      name                  = "NV-Cyclers"
      priority              = "220"
      direction             = "Inbound"
      source_address_prefix = "10.100.250.0/23"
      access                = "Allow"
      description           = "Allow connections from NV-Cyclers"
    },
    {
      name                  = "NV-Cyclers-10b"
      priority              = "222"
      direction             = "Inbound"
      source_address_prefix = "10.149.36.0/22"
      access                = "Allow"
      description           = "Allow connections from NV-Cyclers"
    },        
  ]
}
