terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.8.0"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm"
}

include {
  path = find_in_parent_folders()
}

dependency "vnet" {
  config_path = "../../vnet"
}

dependency "rv" {
  config_path = "../../recovery_vault"
}

inputs = {
  setup_prefix                           = "labx-ett"
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  subnet_id                              = dependency.vnet.outputs.subnets.labx_subnet.id
  vm_name                                = basename(get_terragrunt_dir())
  managed_disk_type                      = "StandardSSD_LRS"
  vm_size                                = "Standard_B2ms"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  localadmin_name                        = "nvadmin"
  localadmin_key_name                    = "nv-labx-nvadmin-ett"
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = "true"
  managed_disk_name                      = "labx-ett-vm-osdisk"

  storage_image_reference = {
    sku = include.root.locals.all_vars.local.windows_server_sku,
  }

  os_profile_windows_config = {
    provision_vm_agent         = true
    enable_automatic_upgrades  = true
    timezone                   = null
    winrm                      = null
    additional_unattend_config = null
  }

  os_profile = {
    admin_username = "nvadmin"
    computer_name  = basename(get_terragrunt_dir())
  }

  network_security_groups = [
    {
      name               = "labx-ett-vm-nsg"
      move_default_rules = true
      rules = [
        {
          name                   = "LocalSubnet"
          priority               = "205"
          direction              = "Inbound"
          source_address_prefix  = "10.44.2.0/26"
          protocol               = "Tcp"
          destination_port_range = "0-65535"
          access                 = "Allow"
          description            = "Allow connections from local subnet"
        },
        {
          name                   = "QC_Network_Ett"
          priority               = "210"
          direction              = "Inbound"
          source_address_prefix  = "10.192.16.0/23"
          protocol               = "*"
          destination_port_range = "0-65535"
          access                 = "Allow"
          description            = "Allow connections from Ett Quality Control Network"
        },
      ]
    },
  ]

  network_interfaces = [
    {
      name                = "${basename(get_terragrunt_dir())}-nic"
      security_group_name = "labx-ett-vm-nsg"
      ip_configuration = [
        {
          ipaddress                     = "10.44.2.17"
          subnet_id                     = dependency.vnet.outputs.subnets.labx_subnet.id
          public_ip                     = false
          private_ip_address_allocation = "Dynamic"
          ipconfig_name                 = "ipconfig"
        },
      ]
    }
  ]

  data_disks = [
    {
      name                 = "${basename(get_terragrunt_dir())}-data1"
      size                 = "25"
      lun                  = "5"
      storage_account_type = "Premium_LRS"
    }
  ]
}

