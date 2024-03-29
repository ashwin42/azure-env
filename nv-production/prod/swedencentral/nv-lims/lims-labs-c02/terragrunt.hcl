terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.8.7"
  # source = "${dirname(get_repo_root())}/tf-mod-azure/vm//netbox"
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
  host_pool_name  = "nv-lims-03-hp"
}

inputs = {
  token                                  = dependency.wvd.outputs.tokens[local.host_pool_name]
  host_pool_name                         = local.host_pool_name
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_name                                = local.name
  name                                   = local.name
  vm_size                                = "Standard_B8ms"
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
  storage_image_reference = {
    id        = "/subscriptions/0f5f2447-3af3-4bbf-98fb-ac9664f75bdc/resourceGroups/nv-lims-rg/providers/Microsoft.Compute/images/lims-labs-c1-image-20221116205549-swedencentral"
    publisher = ""
  }
  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
    timezone                  = "W. Europe Standard Time"
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
          private_ip_address            = "10.64.1.43"
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
    wvd_drain = true
    reboot    = "Always"
    schedule = {
      frequency          = "Week"
      advanced_week_days = ["Wednesday"]
      start_time         = "2023-10-04T01:00:00Z"
    }
  }

}

