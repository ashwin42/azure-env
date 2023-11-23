terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.7.59"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm/netbox"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "rv" {
  config_path = "../../recovery_vault"
}

dependency "rg" {
  config_path = "../../resource_group"
}

dependency "subnet" {
  config_path = "../../subnet"
}

locals {
  vm_name = "rv1-scada-siemens-wincc-01"
  subnet  = "revolt-scada-subnet"
}

inputs = {
  vm_name                                = local.vm_name
  resource_group_name                    = dependency.rg.outputs.resource_group_name
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  backup_vm                              = true
  boot_diagnostics_enabled               = true
  create_avset                           = true
  ad_join                                = true
  storage_account_name                   = "nvprodbootdiagswc"
  create_localadmin_password             = true
  localadmin_name                        = "${local.vm_name}-nvadmin"
  vm_size                                = "Standard_B8ms"
  managed_disk_name                      = "${local.vm_name}-osdisk"
  install_winrm                          = true
  storage_image_reference = {
    sku = "2019-Datacenter-smalldisk",
  }

  os_profile_windows_config = {
    provision_vm_agent = true
    timezone           = "W. Europe Standard Time"
  }

  os_profile = {
    admin_username = "nvadmin"
    computer_name  = "rv1-wincc-01"
  }

  data_disks = [
    {
      name                 = "${local.vm_name}-data1"
      size                 = "256"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
    },
  ]

  network_interfaces = [
    {
      primary             = true
      name                = "${local.vm_name}-nic1"
      security_group_name = "${local.vm_name}-nsg"
      ip_configuration = [{
        subnet_id                     = dependency.subnet.outputs.subnets["${local.subnet}"].id
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.64.1.212"
      }]
    }
  ]

  custom_rules = [
    {
      name                   = "FC.D1.NG.NGS01.IT_TCP_102"
      priority               = "211"
      direction              = "Inbound"
      source_address_prefix  = "10.108.160.0/28"
      protocol               = "Tcp"
      destination_port_range = "102"
      description            = "Allow TCP connections from FC.D1.NG.NGS01.IT on port 102"
    },
    {
      name                   = "FC.D1.NG.NGS01.IT_TCP_135"
      priority               = "212"
      direction              = "Inbound"
      source_address_prefix  = "10.108.160.0/28"
      protocol               = "Tcp"
      destination_port_range = "135"
      description            = "Allow TCP connections from FC.D1.NG.NGS01.IT on port 135"
    },
    {
      name                   = "FC.D1.NG.NGS01.IT_TCP_4840"
      priority               = "213"
      direction              = "Inbound"
      source_address_prefix  = "10.108.160.0/28"
      protocol               = "Tcp"
      destination_port_range = "4840"
      description            = "Allow TCP connections from FC.D1.NG.NGS01.IT on port 4840"
    },
    {
      name                   = "FC.D1.NG.NGS01.IT_TCP_52601"
      priority               = "214"
      direction              = "Inbound"
      source_address_prefix  = "10.108.160.0/28"
      protocol               = "Tcp"
      destination_port_range = "52601"
      description            = "Allow TCP connections from FC.D1.NG.NGS01.IT on port 52601"
    },
    {
      name                   = "FC.D1.NG.NGS01.IT_UDP_137-138"
      priority               = "215"
      direction              = "Inbound"
      source_address_prefix  = "10.108.160.0/28"
      protocol               = "Udp"
      destination_port_range = "137-138"
      description            = "Allow UDP connections from FC.D1.NG.NGS01.IT on port 137-138"
    },
    {
      name                   = "FC.D1.NG.NGS01.IT_UDP_161-162"
      priority               = "216"
      direction              = "Inbound"
      source_address_prefix  = "10.108.160.0/28"
      protocol               = "Udp"
      destination_port_range = "161-162"
      description            = "Allow UDP connections from FC.D1.NG.NGS01.IT on port 161-162"
    },
    {
      name                   = "FC.D1.SC.SCO01.IT_TCP_102"
      priority               = "221"
      direction              = "Inbound"
      source_address_prefix  = "10.108.160.16/28"
      protocol               = "Tcp"
      destination_port_range = "102"
      description            = "Allow TCP connections from FC.D1.SC.SCO01.IT on port 102"
    },
    {
      name                   = "FC.D1.SC.SCO01.IT_TCP_135"
      priority               = "222"
      direction              = "Inbound"
      source_address_prefix  = "10.108.160.16/28"
      protocol               = "Tcp"
      destination_port_range = "135"
      description            = "Allow TCP connections from FC.D1.SC.SCO01.IT on port 135"
    },
    {
      name                   = "FC.D1.SC.SCO01.IT_TCP_4840"
      priority               = "223"
      direction              = "Inbound"
      source_address_prefix  = "10.108.160.16/28"
      protocol               = "Tcp"
      destination_port_range = "4840"
      description            = "Allow TCP connections from FC.D1.SC.SCO01.IT on port 4840"
    },
    {
      name                   = "FC.D1.SC.SCO01.IT_TCP_52601"
      priority               = "224"
      direction              = "Inbound"
      source_address_prefix  = "10.108.160.16/28"
      protocol               = "Tcp"
      destination_port_range = "52601"
      description            = "Allow TCP connections from FC.D1.SC.SCO01.IT on port 52601"
    },
    {
      name                   = "FC.D1.SC.SCO01.IT_UDP_137-138"
      priority               = "225"
      direction              = "Inbound"
      source_address_prefix  = "10.108.160.16/28"
      protocol               = "Udp"
      destination_port_range = "137-138"
      description            = "Allow UDP connections from FC.D1.SC.SCO01.IT on port 137-138"
    },
    {
      name                   = "FC.D1.SC.SCO01.IT_UDP_161-162"
      priority               = "226"
      direction              = "Inbound"
      source_address_prefix  = "10.108.160.16/28"
      protocol               = "Udp"
      destination_port_range = "161-162"
      description            = "Allow UDP connections from FC.D1.SC.SCO01.IT on port 161-162"
    },
  ]
}

