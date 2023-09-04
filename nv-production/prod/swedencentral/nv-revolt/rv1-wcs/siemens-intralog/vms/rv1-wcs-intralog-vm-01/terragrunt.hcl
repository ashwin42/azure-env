terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.7.59"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/vm/"
}

include {
  path = find_in_parent_folders()
}

dependency "rv" {
  config_path = "../../recovery_vault"
}

dependency "subnet" {
  config_path = "../../subnet"
}

locals {
  name       = basename(get_original_terragrunt_dir())
  subnet     = "revolt-wcs-subnet-01"
  app_subnet = "revolt-wcs-web-app-01"
}

inputs = {
  vm_name                                = local.name
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_size                                = "Standard_B8ms"
  create_avset                           = true
  boot_diagnostics_enabled               = true
  install_winrm                          = true
  backup_vm                              = true
  ad_join                                = true
  create_localadmin_password             = true
  localadmin_name                        = "rv1-wcs-intralog-nvadmin"
  managed_disk_name                      = "${local.name}-osdisk"

  storage_image_reference = {
    sku = "2022-Datacenter-smalldisk",
  }

  os_profile_windows_config = {
    enable_automatic_upgrades = false
    provision_vm_agent        = true
    timezone                  = "W. Europe Standard Time"
  }

  os_profile = {
    admin_username = "nvadmin"
    computer_name  = "rv1-intralog-01"
  }

  data_disks = [
    {
      name                 = "${local.name}-data1"
      size                 = "256"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
    },
  ]

  network_interfaces = [
    {
      name    = "${local.name}-nic1"
      primary = true
      ip_configuration = [{
        subnet_id                     = dependency.subnet.outputs.subnets["${local.subnet}"].id
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.64.1.230"
      }]
    }
  ]

  custom_rules = [
    {
      name                  = "LocalSubnet"
      priority              = "205"
      direction             = "Inbound"
      source_address_prefix = dependency.subnet.outputs.subnets["${local.subnet}"].address_prefixes[0]
      description           = "Allow connections from local subnet"
    },
    {
      name                   = "Siemens_mgmt_wvd"
      priority               = "201"
      direction              = "Inbound"
      source_address_prefix  = "10.46.2.96/29"
      protocol               = "Tcp"
      destination_port_range = "3389"
      access                 = "Allow"
      description            = "Allow connections from Siemens Mgmt subnet"
    },
    {
      name                   = "LocalSubnetInboundWebApp"
      priority               = "210"
      direction              = "Inbound"
      source_address_prefix  = dependency.subnet.outputs.subnets["${local.app_subnet}"].address_prefixes[0]
      protocol               = "Tcp"
      destination_port_range = "4711,5005"
      description            = "Allow connections from local web delegated subnet"
    },
    {
      name      = "AutomationAccountAWS-DigiTrafficControl"
      priority  = "220"
      direction = "Inbound"
      source_address_prefixes = [
        "10.21.13.0/24",
        "10.21.14.0/24",
        "10.21.15.0/24",
      ]
      destination_port_range = "5000-5020"
      protocol               = "Tcp"
      description            = "Allow connections from Digitalization Traffic Control Team, AWS Automation Account"
    }
  ]
}

