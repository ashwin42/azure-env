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

locals {
  name = basename(get_terragrunt_dir())
}


inputs = {
  token                         = dependency.wvd.outputs.tokens.nv-asrs-hp
  host_pool_name                = dependency.wvd.outputs.host_pools.nv-asrs-hp.name
  vm_size                       = "Standard_B4ms"
  key_vault_name                = "nv-infra-core"
  key_vault_rg                  = "nv-infra-core"
  localadmin_key_name           = "localadmin"
  netbox_role                   = "asrs"
  vm_name                       = "asrs01"
  name                          = "asrs01"
  delete_os_disk_on_termination = true
  aad_join                      = true
  mdm_register                  = true
  wvd_register                  = true
  create_localadmin_password    = true
  install_winrm                 = true
  #dns_servers                   = null

  storage_image_reference = include.root.inputs.windows_10_ltsc_image

  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
    timezone                  = "W. Europe Standard Time"
  }

  os_profile = {
    admin_username = "domainjoin"
    computer_name  = "asrs01"
  }

  identity = {
    type = "SystemAssigned"
  }

  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          private_ip_address            = "10.67.1.6"
          subnet_id                     = dependency.vnet.outputs.subnets["nv-asrs-monitoring-subnet-10.67.1.0_28"].id
          public_ip                     = false
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "${local.name}-ipconfig"
        },
      ]
    },
  ]

  iam_assignments = {
    "Virtual Machine Administrator Login" = {
      groups = [
        "NV TechOps Role",
        "NV Network Member"
      ],
    },
  }
}

