terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.8.8"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "global" {
  config_path = "../global"
}

dependency "avd" {
  config_path = "../avd-cnp-01"
}

locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  setup_prefix                           = dependency.global.outputs.setup_prefix
  token                                  = dependency.avd.outputs.tokens["${local.name}-hp"]
  host_pool_name                         = dependency.avd.outputs.host_pools["${local.name}-hp"].name
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
  name                                   = local.name
  vm_name                                = local.name
  vm_size                                = "Standard_DS4_v2"
  backup_vm                              = true
  create_localadmin_password             = true
  storage_account_name                   = "nvinfrabootdiag"
  boot_diagnostics_enabled               = true
  ad_join                                = true
  wvd_register                           = true
  install_winrm                          = true
  ou_path                                = "OU=PNE Cycler VMs,DC=aadds,DC=northvolt,DC=com"

  storage_image_reference = {
    offer     = "Windows-10",
    publisher = "MicrosoftWindowsDesktop",
    sku       = "win10-22h2-avd-g2",
  }

  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
    timezone                  = "W. Europe Standard Time"
  }

  os_profile = {
    admin_username = "nvadmin"
    computer_name  = local.name
  }

  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          private_ip_address            = "10.44.5.47"
          subnet_id                     = dependency.global.outputs.subnet["nv-pne-subnet-10.44.5.32"].id
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "${local.name}-nic-ipconfig"
        }
      ]
    }
  ]

  data_disks = [
    {
      name                 = "${local.name}-datadisk01"
      size                 = "4096"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
      caching              = "None"
    }
  ]

  custom_rules = [
    {
      name                  = "FR.T2.OC.CPM01.IT"
      priority              = "220"
      direction             = "Inbound"
      source_address_prefix = "10.101.232.32/28"
      access                = "Allow"
      description           = "Allow connections from cyclers on FR.T2.OC.CPM01.IT"
    },
    {
      name                  = "FR.T2.IC.CPM01.IT"
      priority              = "221"
      direction             = "Inbound"
      source_address_prefix = "10.101.232.48/28"
      access                = "Allow"
      description           = "Allow connections from cyclers on FR.T2.IC.CPM01.IT"
    },
    {
      name                  = "FR.T2.IC.CPM02.IT"
      priority              = "222"
      direction             = "Inbound"
      source_address_prefix = "10.101.232.64/28"
      access                = "Allow"
      description           = "Allow connections from cyclers on FR.T2.IC.CPM02.IT"
    },
    {
      name                  = "FR.T2.IC.CPM03.IT"
      priority              = "223"
      direction             = "Inbound"
      source_address_prefix = "10.101.232.80/28"
      access                = "Allow"
      description           = "Allow connections from cyclers on FR.T2.IC.CPM03.IT"
    },
  ]
}
