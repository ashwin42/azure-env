terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.8.6"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../../../global/vnet/"
}

dependency "wvd" {
  config_path = "../../wvd"
}

locals {
  name = basename(get_terragrunt_dir())
}


inputs = {
  token                         = dependency.wvd.outputs.tokens.lasernet-test-hp
  vm_size                       = "Standard_B4ms"
  key_vault_rg                  = "global-rg"
  secrets_key_vault_rg          = "global-rg"
  key_vault_name                = "nv-erp-dev-we-secrets"
  localadmin_key_name           = "localadmin"
  vm_name                       = local.name
  name                          = local.name
  delete_os_disk_on_termination = true
  aad_join                      = true
  mdm_register                  = true
  wvd_register                  = true
  create_localadmin_password    = true
  install_winrm                 = true

  storage_image_reference = include.root.inputs.windows_10_ltsc_image

  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
    timezone                  = "W. Europe Standard Time"
  }

  os_profile = {
    admin_username = "domainjoin"
    computer_name  = local.name
  }

  identity = {
    type = "SystemAssigned"
  }

  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          private_ip_address            = "10.46.44.11"
          subnet_id                     = dependency.vnet.outputs.subnet.general_subnet1.id
          public_ip                     = false
          private_ip_address_allocation = "Static"
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

