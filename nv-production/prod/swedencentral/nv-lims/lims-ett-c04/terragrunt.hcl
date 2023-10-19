terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.9.2"
  #source = "../../../../../../tf-mod-azure//vm/"
}

include {
  path = find_in_parent_folders()
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
  host_pool_name  = "nv-lims-02-hp"
}

inputs = {
  token                                  = dependency.wvd.outputs.tokens[local.host_pool_name]
  host_pool_name                         = local.host_pool_name
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_name                                = local.name
  name                                   = local.name
  vm_size                                = "Standard_D8ds_v5"
  backup_vm                              = true
  key_vault_name                         = "nv-production-core"
  key_vault_rg                           = "nv-production-core"
  localadmin_name                        = local.localadmin_name
  localadmin_key_name                    = "${local.name}-${local.localadmin_name}"
  create_localadmin_password             = true
  storage_account_name                   = "nvprodbootdiagswc"
  boot_diagnostics_enabled               = true
  ad_join                                = true
  wvd_register                           = true
  managed_disk_size                      = "256"
  storage_image_reference = {
    id        = "/subscriptions/0f5f2447-3af3-4bbf-98fb-ac9664f75bdc/resourceGroups/nv-lims-rg/providers/Microsoft.Compute/images/lims-ett-c0x-image-20231009171952"
    publisher = ""
  }
  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
    timezone                  = "Central Europe Standard Time"
  }
  os_type = "Windows"
  os_profile = {
    admin_username = local.localadmin_name
    computer_name  = local.name
  }
  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          private_ip_address            = "10.64.1.41"
          subnet_id                     = dependency.vnet.outputs.subnet["nv-lims-subnet-10.64.1.32_27"].id
          public_ip                     = false
          private_ip_address_allocation = "Static"
        },
      ]
    },
  ]
  custom_rules = [
    {
      name                   = "Allow_LIMS"
      priority               = "202"
      direction              = "Inbound"
      source_address_prefix  = "10.64.1.32/27"
      protocol               = "*"
      destination_port_range = "0-65535"
      access                 = "Allow"
      description            = "Allow connections from Lims clients"
    },
  ]
  iam_assignments = {
    "Desktop Virtualization Power On Off Contributor" = {
      groups = [
        "Labware LIMS Developers",
      ],
    },
  }
  automation_updates = {
    wvd_drain          = true
    wvd_drain_reminder = true
    reboot             = "Always"
    schedule = {
      frequency                       = "Week"
      advanced_week_days              = ["Thursday"]
      start_time                      = "2023-10-26T05:00:00Z"
      drain_schedule_reminder_message = "This VM will be patched and restarted in 5 minutes. Please save your work and log off."
    }
  }
}

