terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.7.39"
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
        private_ip_address            = "10.46.2.85"
      }]
    }
  ]

  custom_rules = [
    {
      name                  = "Labs_MFA_VPN"
      priority              = "200"
      direction             = "Inbound"
      source_address_prefix = "10.16.8.0/23"
      description           = "Allow connections from Labs MFA VPN clients"
    },
    {
      name                  = "Ett_MFA_VPN"
      priority              = "201"
      direction             = "Inbound"
      source_address_prefix = "10.240.0.0/21"
      description           = "Allow connections from Ett MFA VPN clients"
    },
    {
      name                  = "LocalSubnet"
      priority              = "205"
      direction             = "Inbound"
      source_address_prefix = dependency.subnet.outputs.subnets["${local.subnet}"].address_prefixes[0]
      description           = "Allow connections from local subnet"
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
      name                  = "ICMP"
      priority              = "300"
      direction             = "Inbound"
      source_address_prefix = "10.0.0.0/8"
      protocol              = "Icmp"
      description           = "Allow ICMP"
    },
  ]
}

