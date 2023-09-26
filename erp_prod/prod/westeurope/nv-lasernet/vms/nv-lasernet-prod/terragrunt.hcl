terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.8.6"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../../subnet"
}

dependency "wvd" {
  config_path = "../../wvd"
}

dependency "rv" {
  config_path = "../../recovery_vault"
}

locals {
  name = basename(get_terragrunt_dir())
}


inputs = {
  token                                  = dependency.wvd.outputs.tokens.nv-lasernet-hp
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_size                                = "Standard_B4ms"
  key_vault_name                         = "erp-prod-rg"
  key_vault_rg                           = "erp-prod-rg"
  localadmin_key_name                    = "localadmin"
  vm_name                                = local.name
  name                                   = local.name
  delete_os_disk_on_termination          = true
  aad_join                               = true
  mdm_register                           = true
  wvd_register                           = true
  create_localadmin_password             = true
  install_winrm                          = true

  storage_image_reference = {
    offer     = "Windows-10",
    publisher = "MicrosoftWindowsDesktop",
    sku       = "21h1-evd-g2",
  }

  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
    timezone                  = "W. Europe Standard Time"
  }

  os_profile = {
    admin_username = "domainjoin"
    computer_name  = "lasernet001"
  }

  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          private_ip_address            = "10.46.32.36"
          subnet_id                     = dependency.vnet.outputs.subnets["nv-lasernet-subnet-10.46.32.32_28"].id
          public_ip                     = false
          private_ip_address_allocation = "Dynamic"
          ipconfig_name                 = "${local.name}-ipconfig"
        },
      ]
    },
  ]

  data_disks = [
    {
      name                 = "${local.name}-data"
      size                 = "100"
      lun                  = "5"
      storage_account_type = "Standard_LRS"
    }
  ]

  iam_assignments = {
    "Virtual Machine Administrator Login" = {
      groups = [
        "NV TechOps Role",
        "NV Business Systems Common Member"
      ],
    },
  }
}

