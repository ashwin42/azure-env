terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.8.0"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../../vnet"
}

dependency "rv" {
  config_path = "../../recovery_vault"
}

locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  subnet_id                              = dependency.vnet.outputs.subnets.labx_subnet.id
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
    provision_vm_agent        = true
    enable_automatic_upgrades = true
  }

  identity = {
    type = "SystemAssigned"
  }

  network_security_groups = [
    {
      name               = "labware-web-dev-nsg"
      move_default_rules = true
      rules = [
        {
          name                  = "LocalSubnet"
          priority              = "205"
          direction             = "Inbound"
          source_address_prefix = dependency.vnet.outputs.subnets.labx_subnet.address_prefixes.0
          access                = "Allow"
          description           = "Allow connections from local subnet"
        }
      ]
    },
  ]

  network_interfaces = [
    {
      name                = "${local.name}-nic1"
      security_group_name = "labware-web-dev-nsg"
      ip_configuration = [
        {
          private_ip_address            = "10.44.2.15"
          subnet_id                     = dependency.vnet.outputs.subnets.labx_subnet.id
          ipconfig_name                 = "${local.name}-nic_config"
          private_ip_address_allocation = "Static"
        },
      ]
    },
  ]
}
