terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.7.59"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "rv" {
  config_path = "../recovery_vault"
}

dependency "subnet" {
  config_path = "../subnet"
}

locals {
  name              = basename(get_original_terragrunt_dir())
  sql_data_disk_lun = 5
}

inputs = {
  netbox_role                            = "pqms"
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_name                                = local.name
  vm_size                                = "Standard_E4ds_v5"
  backup_vm                              = true
  create_sql_backup_policy               = true
  ad_join                                = true
  create_localadmin_password             = true
  managed_disk_size                      = 127
  boot_diagnostics_enabled               = true
  install_winrm                          = true

  storage_image_reference = {
    offer     = "sql2019-ws2019",
    publisher = "MicrosoftSQLServer",
    sku       = "Standard",
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

  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = false
    timezone                  = "W. Europe Standard Time"
  }

  os_profile = {
    admin_username = "nvadmin"
    computer_name  = local.name
  }

  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          private_ip_address            = "10.64.1.148"
          subnet_id                     = dependency.subnet.outputs.subnets["pqms-subnet"].id
          ipconfig_name                 = "${local.name}-nic_config"
          private_ip_address_allocation = "Static"
        },
      ]
    },
  ]

  data_disks = [
    {
      name                 = "${local.name}-data"
      size                 = "512"
      caching              = "ReadOnly"
      lun                  = local.sql_data_disk_lun
      storage_account_type = "Standard_LRS"
    },
  ]

  custom_rules = [
    {
      name                  = "LocalVnet"
      priority              = "205"
      direction             = "Inbound"
      source_address_prefix = dependency.subnet.outputs.subnets["pqms-subnet"].address_prefixes[0]
      access                = "Allow"
      description           = "Allow connections from local VNet"
    },
  ]
}

