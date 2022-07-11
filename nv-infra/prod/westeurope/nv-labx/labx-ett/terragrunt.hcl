terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.3.0"
}

include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

inputs = {
  setup_prefix                           = "labx-ett"
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = "nv_labx"
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = "nv_labx"
  subnet_id                              = dependency.global.outputs.subnet.labx_subnet.id
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
  storage_image_reference = {
    sku = "2016-Datacenter",
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
  network_interfaces = [
    {
      name      = "${basename(get_terragrunt_dir())}-nic"
      ip_configuration = [
        {
          ipaddress                     = "10.44.2.17"
          subnet_id                     = dependency.global.outputs.subnet.labx_subnet.id
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
  custom_rules = [
    {
      name                  = "Labs_MFA_VPN"
      priority              = "200"
      direction             = "Inbound"
      source_address_prefix = "10.16.8.0/23"      
      protocol              = "Tcp"
      destination_port_range = "0-65535"
      access                = "Allow"
      description           = "Allow connections from Labs MFA VPN clients"
    },
    {
      name                   = "Ett_MFA_VPN"
      priority               = "201"
      direction              = "Inbound"
      source_address_prefix  = "10.240.0.0/21"
      protocol               = "*"
      destination_port_range = "0-65535"
      access                 = "Allow"
      description            = "Allow connections from Ett MFA VPN clients"
    },
    {
      name                  = "LocalSubnet"
      priority              = "205"
      direction             = "Inbound"
      source_address_prefix = "10.44.2.0/26"
      protocol              = "Tcp"
      destination_port_range = "0-65535"
      access                = "Allow"
      description           = "Allow connections from local subnet"
    },
  ]
}
