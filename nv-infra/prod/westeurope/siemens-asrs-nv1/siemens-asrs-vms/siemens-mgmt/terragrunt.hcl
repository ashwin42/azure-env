terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.8.7"
  # source = "${dirname(get_repo_root())}/tf-mod-azure/vm//netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../../vnet"
}

dependency "wvd" {
  config_path = "../../wvd"
}

locals {
  name = "siemens-mgmt"
}

inputs = {
  delete_os_disk_on_termination = true
  token                         = dependency.wvd.outputs.tokens["${local.name}-aad-mdm"]
  host_pool_name                = dependency.wvd.outputs.host_pools["${local.name}-aad-mdm"].name
  name                          = local.name
  vm_size                       = "Standard_B2ms"
  aad_join                      = true
  mdm_register                  = true
  wvd_register                  = true
  key_vault_name                = "nv-infra-core"
  key_vault_rg                  = "nv-infra-core"
  create_localadmin_password    = true
  localadmin_name               = "nvadmin"
  localadmin_key_name           = "${local.name}-nvadmin"
  storage_account_name          = "nvinfrabootdiag"
  install_winrm                 = true
  boot_diagnostics_enabled      = true

  os_profile_windows_config = {
    enable_automatic_upgrades = true
    provision_vm_agent        = true
    timezone                  = "W. Europe Standard Time"
  }

  storage_image_reference = {
    offer     = "Windows-10",
    publisher = "MicrosoftWindowsDesktop",
    sku       = "21h1-evd-g2",
    version   = "latest"
  }

  identity = {
    type = "SystemAssigned"
  }

  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          subnet_id          = dependency.vnet.outputs.subnets["${local.name}-subnet"].id
          private_ip_address = "10.46.2.100"
        },
      ]
    },
  ]

  iam_assignments = {
    "Virtual Machine Administrator Login" = {
      groups = [
        "NV TechOps Role",
      ],
    },
    "Virtual Machine User Login" = {
      groups = [
        "VPN Siemens ASRS AP",
      ],
    },
  }

  automation_updates = {
    wvd_drain = true
    schedule = {
      frequency          = "Week"
      advanced_week_days = ["Monday"]
      start_time         = "2023-10-02T23:00:00Z"
    }
  }
}
