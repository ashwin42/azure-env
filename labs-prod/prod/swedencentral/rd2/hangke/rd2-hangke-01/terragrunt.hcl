terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.9.8"
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
  name                                   = local.name
  vm_size                                = "Standard_D4_v5"
  managed_disk_size                      = 256
  backup_vm                              = true
  localadmin_name                        = local.localadmin_name
  localadmin_key_name                    = "${local.name}-${local.localadmin_name}"
  create_localadmin_password             = true
  boot_diagnostics_enabled               = true
  ad_join                                = true
  wvd_register                           = true
  netbox_role                            = "hangke"
  identity = {
    type         = "SystemAssigned"
    identity_ids = null
  }
  storage_image_reference = {
    offer     = "Windows-10",
    publisher = "MicrosoftWindowsDesktop",
    sku       = "win10-22h2-avd-g2",
  }
  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = false
    timezone                  = "W. Europe Standard Time"
  }
  os_profile = {
    admin_username = local.localadmin_name
    computer_name  = local.name
  }
  data_disks = [
    {
      name                 = "${local.name}-datadisk01"
      size                 = "1024"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
      caching              = "None"
    }
  ]
  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          private_ip_address            = "10.64.97.4"
          private_ip_address_allocation = "Static"
          subnet_id                     = dependency.vnet.outputs.subnets["rd2-hangke-10.64.97.0_29"].id
        },
      ]
    },
  ]
  repo_tag = {
    repo = "azure-env/labs-prod/prod/swedencentral/rd2/hangke/rd2-hangke-01"
  }
  automation_updates = {
    wvd_drain                 = true
    wvd_drain_role_assignment = true
    wvd_drain_reminder        = true
    reboot                    = "Always"
    schedule = {
      frequency                       = "Week"
      advanced_week_days              = ["Sunday"]
      start_time                      = "2023-12-17T23:00:00Z"
      drain_schedule_reminder_message = "This VM will be patched and restarted in 5 minutes. Please save your work and log off."
    }
  }
}

