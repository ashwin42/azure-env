terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.8.5"
}

include {
  path = find_in_parent_folders()
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common-vms.hcl"))
}

inputs = merge(
  local.common.inputs,
  {
    netbox_create_role = true
    install_winrm      = true
    network_interfaces = [
      {
        name           = "dwa-prn-nic1"
        security_group = "dwa-prn-custom-nsg"
        primary        = true
        ip_configuration = [{
          subnet_id                     = local.common.dependency.subnet.outputs.subnets["office-it-subnet1"].id
          private_ip_address_allocation = "Static"
          private_ip_address            = "10.46.97.133"
        }]
      }
    ]
    custom_rules = [
      {
        name                   = "dwa_printer_umango1"
        priority               = "203"
        direction              = "Inbound"
        source_address_prefix  = "10.17.16.0/27"
        protocol               = "Tcp"
        destination_port_range = "389"
        access                 = "Allow"
        description            = "Allow connections from Dwa office subnet"
      },
      {
        name                   = "dwa_printer_umango2"
        priority               = "204"
        direction              = "Inbound"
        source_address_prefix  = "10.17.16.0/27"
        protocol               = "Tcp"
        destination_port_range = "445"
        access                 = "Allow"
        description            = "Allow connections from Dwa office subnet"
      },
      {
        name                   = "dwa_printer_umango3"
        priority               = "205"
        direction              = "Inbound"
        source_address_prefix  = "10.17.16.0/27"
        protocol               = "Tcp"
        destination_port_range = "443"
        access                 = "Allow"
        description            = "Allow connections from Dwa office subnet"
      },
      {
        name                   = "dwa_printer_umango4"
        priority               = "206"
        direction              = "Inbound"
        source_address_prefix  = "10.17.16.0/27"
        protocol               = "Tcp"
        destination_port_range = "50080-50081"
        access                 = "Allow"
        description            = "Allow connections from Dwa office subnet"
      },
      {
        name                   = "dwa_printer_papercut1"
        priority               = "207"
        direction              = "Inbound"
        source_address_prefix  = "10.17.16.0/27"
        protocol               = "Tcp"
        destination_port_range = "9191-9193"
        access                 = "Allow"
        description            = "Allow connections from Dwa office subnet"
      },
      {
        name                   = "dwa_printer_papercut2"
        priority               = "208"
        direction              = "Inbound"
        source_address_prefix  = "10.17.16.0/27"
        protocol               = "Tcp"
        destination_port_range = "636"
        access                 = "Allow"
        description            = "Allow connections from Dwa office subnet"
      },
      {
        name                   = "dwa_printer_princity"
        priority               = "209"
        direction              = "Inbound"
        source_address_prefix  = "10.17.16.0/27"
        protocol               = "Udp"
        destination_port_range = "161-162"
        access                 = "Allow"
        description            = "Allow connections from Dwa office subnet"
      }
    ]
  }
)

