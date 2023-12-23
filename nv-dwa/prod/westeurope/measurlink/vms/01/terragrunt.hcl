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

locals {
  name              = "measurlinkdwa${basename(get_original_terragrunt_dir())}"
  sql_data_disk_lun = 5
}

inputs = {
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  name                                   = local.name
  vm_size                                = "Standard_E4ds_v5"
  storage_account_name                   = "nvdwainfrabootdiag"
  boot_diagnostics_enabled               = true
  backup_vm                              = true
  create_sql_backup_policy               = true
  ad_join                                = true
  create_localadmin_password             = true
  install_winrm                          = true
  netbox_role                            = "measurlink"
  managed_disk_size                      = 127
  storage_image_reference = {
    offer     = "sql2019-ws2019",
    publisher = "MicrosoftSQLServer",
    sku       = "Standard",
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
      caching              = "ReadOnly"
    }
  ]
  maintenance_configurations = [
    {
      name = "first_sunday_2200"
    },
  ]
}

