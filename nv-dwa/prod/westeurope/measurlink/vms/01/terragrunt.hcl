terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.10.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../../subnet"
}

dependency "rv" {
  config_path = "../../recovery_vault"
}

dependency "avd" {
  config_path = "../../avd/01"
}

locals {
  name              = "measurlinkdwa${basename(get_original_terragrunt_dir())}"
  sql_data_disk_lun = 5
}

inputs = {
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  name                                   = local.name
  vm_size                                = "Standard_D4a_v4"
  storage_account_name                   = "nvdwainfrabootdiag"
  boot_diagnostics_enabled               = true
  backup_vm                              = true
  ad_join                                = true
  create_localadmin_password             = true
  install_winrm                          = true
  netbox_role                            = "measurlink"
  netbox_tags                            = ["monitoring:windows_node_exporter"]
  managed_disk_size                      = 256
  mssql_virtual_machine                  = true
  wvd_register                           = true
  token                                  = values(dependency.avd.outputs.tokens)[0]
  host_pool_name                         = keys(dependency.avd.outputs.host_pools)[0]
  storage_image_reference = {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "win10-22h2-avd-g2",
  }
  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = false
    timezone                  = "W. Europe Standard Time"
  }
  os_profile = {
    admin_username = "nvadmin"
    computer_name  = local.name
  }
  mssql_storage_configuration = {
    disk_type             = "NEW"
    storage_workload_type = "OLTP"
    data_settings = {
      default_file_path = "F:\\data"
      luns              = [local.sql_data_disk_lun]
    }
    log_settings = {
      default_file_path = "F:\\log"
      luns              = [local.sql_data_disk_lun]
    }
    temp_db_settings = {
      default_file_path = "D:\\tempdb"
      luns              = []
    }
  }
  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          private_ip_address            = "10.46.97.148"
          subnet_id                     = dependency.vnet.outputs.subnets["measurlink-dwa-10.46.97.144_29"].id
          public_ip                     = false
          private_ip_address_allocation = "Static"
          ipconfig_name                 = "ipconfig"
        },
      ]
    },
  ]
  data_disks = [
    {
      name                 = "${local.name}-datadisk01"
      size                 = "1024"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
      caching              = "None"
    }
  ]
  repo_tag = {
    repo = "azure-env/nv-dwa/prod/westeurope/measurlink/vms/01"
  }
  automation_updates = {
    wvd_drain                 = true
    wvd_drain_role_assignment = true
    wvd_drain_reminder        = true
    reboot                    = "Always"
    schedule = {
      frequency                       = "Week"
      advanced_week_days              = ["Monday"]
      start_time                      = "2023-12-25T01:00:00Z"
      drain_schedule_reminder_message = "This VM will be patched and restarted in 5 minutes. Please save your work and log off."
    }
  }
}

