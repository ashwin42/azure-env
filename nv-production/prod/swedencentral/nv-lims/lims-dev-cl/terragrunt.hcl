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
  host_pool_name  = "nv-lims-04-hp"
  localadmin_name = "nvadmin"
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
    id        = "/subscriptions/0f5f2447-3af3-4bbf-98fb-ac9664f75bdc/resourceGroups/nv-lims-rg/providers/Microsoft.Compute/images/lims-dev-cl-image-20221125125832-swedencentral"
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
          private_ip_address            = "10.64.1.46"
          subnet_id                     = dependency.vnet.outputs.subnets["nv-lims-subnet-10.64.1.32_27"].id
          public_ip                     = false
          private_ip_address_allocation = "Static"
        },
      ]
    },
  ]
  iam_assignments = {
    "Desktop Virtualization Power On Off Contributor" = {
      groups = [
        "Labware LIMS Developers",
      ],
    },
  }
}

