terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.5.0"
  #source = "../../../../../../tf-mod-azure//vm/"
}

include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
  subnet_id                              = dependency.global.outputs.subnet.labx_subnet.id
  name                                   = local.name
  vm_name                                = local.name
  vm_size                                = "Standard_B2ms"
  backup_vm                              = true
  localadmin_name                        = "nvadmin"
  localadmin_key_name                    = "nv-labx"
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = "true"
  managed_disk_size                      = "64"
  storage_image_reference = {
    sku = "2019-Datacenter-smalldisk",
  }
  os_profile_windows_config = {
    provision_vm_agent         = true
    enable_automatic_upgrades  = true
    timezone                   = null
    winrm                      = null
    additional_unattend_config = null
  }
  network_interfaces = [
    {
      name = "${local.name}-nic1"
      ip_configuration = [
        {
          private_ip_address            = "10.44.2.15"
          subnet_id                     = dependency.global.outputs.subnet.labx_subnet.id
          ipconfig_name                 = "${local.name}-nic_config"
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
      name                  = "LocalSubnet"
      priority              = "205"
      direction             = "Inbound"
      source_address_prefix = dependency.global.outputs.subnet.labx_subnet.address_prefixes.0
      access                = "Allow"
      description           = "Allow connections from local subnet"
    }
  ]
}
