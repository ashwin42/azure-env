terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.9.4"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../subnet"
}

dependency "wvd" {
  config_path = "../wvd/01"
}

dependency "rv" {
  config_path = "../recovery_vault"
}

locals {
  name            = basename(get_terragrunt_dir())
  localadmin_name = "nvadmin"
}

inputs = {
  host_pool_name                         = keys(dependency.wvd.outputs.host_pools)[0]
  token                                  = values(dependency.wvd.outputs.tokens)[0]
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_name                                = local.name
  name                                   = local.name
  vm_size                                = "Standard_D16d_v5"
  backup_vm                              = true
  key_vault_name                         = "nv-production-core"
  key_vault_rg                           = "nv-production-core"
  localadmin_name                        = local.localadmin_name
  localadmin_key_name                    = "${local.name}-${local.localadmin_name}"
  create_localadmin_password             = true
  storage_account_name                   = "nvprodbootdiagswc"
  boot_diagnostics_enabled               = true
  ad_join                                = true
  azuread_join                           = false
  wvd_register                           = true
  netbox_role                            = "honeywell"
  identity = {
    type         = "SystemAssigned"
    identity_ids = null
  }
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
    admin_username = local.localadmin_name
    computer_name  = local.name
  }
  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          private_ip_address            = "10.64.1.4"
          subnet_id                     = dependency.vnet.outputs.subnets["nv-honey-subnet-10.64.1.0_28"].id
          public_ip                     = false
          private_ip_address_allocation = "Static"
        },
      ]
    },
  ]
  custom_rules = [
    {
      name                   = "QCS-Server"
      priority               = "202"
      direction              = "Inbound"
      source_address_prefix  = "10.22.88.32/29"
      protocol               = "*"
      destination_port_range = "8095-8096"
      access                 = "Allow"
      description            = "Allow connections from QCS Server for Web and API"
    },
  ]
  iam_assignments = {
    "Desktop Virtualization Power On Off Contributor" = {
      groups = [
        "NV Automation Member",
      ],
    },
  }
}

