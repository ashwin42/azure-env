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

dependency "rv" {
  config_path = "../recovery_vault"
}

locals {
  name            = basename(get_terragrunt_dir())
  localadmin_name = "nvadmin"
}

inputs = {
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_name                                = local.name
  name                                   = local.name
  vm_size                                = "Standard_B2ms"
  backup_vm                              = true
  key_vault_name                         = "nv-production-core"
  key_vault_rg                           = "nv-production-core"
  localadmin_name                        = local.localadmin_name
  localadmin_key_name                    = "${local.name}-${local.localadmin_name}"
  storage_account_name                   = "nvprodbootdiagswc"
  boot_diagnostics_enabled               = true
  ad_join                                = true
  managed_disk_name                      = "lims-web-dev-osdisk"
  identity = {
    type         = "SystemAssigned"
    identity_ids = null
  }
  storage_image_reference = {
    offer     = include.root.locals.all_vars.windows_server_offer,
    publisher = include.root.locals.all_vars.windows_server_publisher,
    sku       = "2019-Datacenter-smalldisk",
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
          private_ip_address            = "10.64.1.48"
          subnet_id                     = dependency.vnet.outputs.subnets["nv-lims-subnet-10.64.1.32_27"].id
          public_ip                     = false
          private_ip_address_allocation = "Static"
        },
      ]
    },
  ]
  custom_rules = [
    {
      name                  = "LocalSubnet"
      priority              = "205"
      direction             = "Inbound"
      source_address_prefix = dependency.vnet.outputs.subnets["nv-lims-subnet-10.64.1.32_27"].address_prefixes.0
      access                = "Allow"
      description           = "Allow connections from local subnet"
    }
  ]

  iam_assignments = {
    "Desktop Virtualization Power On Off Contributor" = {
      groups = [
        "Labware LIMS Developers",
      ],
    },
  }
}

