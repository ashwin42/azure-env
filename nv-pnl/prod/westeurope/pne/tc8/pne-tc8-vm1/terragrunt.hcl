terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.9.2"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../../../global/vnet/"
}

dependency "avd" {
  config_path = "../avd"
}

locals {
  name   = basename(get_terragrunt_dir())
  common = read_terragrunt_config(find_in_parent_folders("common-pnl-vms.hcl"))
}

inputs = merge(
  local.common.inputs,
  {
    token          = dependency.avd.outputs.tokens["${local.name}-hp"]
    host_pool_name = "pne-tc8-vm1-hp"
    storage_image_reference = {
      offer     = include.root.locals.all_vars.windows_10_ltsc_image.offer,
      publisher = include.root.locals.all_vars.windows_10_ltsc_image.publisher,
      sku       = include.root.locals.all_vars.windows_10_ltsc_image.sku,
    }
    network_interfaces = [
      {
        name = "${local.name}-nic"
        ip_configuration = [
          {
            private_ip_address            = "10.46.40.18"
            subnet_id                     = dependency.vnet.outputs.subnets.subnet1.id
            private_ip_address_allocation = "Static"
            ipconfig_name                 = "ipconfig"
          }
        ]
      }
    ]

    data_disks = [
      {
        name                 = "${local.name}-datadisk1"
        size                 = "4096"
        lun                  = "5"
        storage_account_type = "StandardSSD_LRS"
        caching              = "None"
      }
    ]

    custom_rules = concat(local.common.locals.custom_rules, [
      {
        name                  = "NV-Cyclers"
        priority              = "221"
        direction             = "Inbound"
        source_address_prefix = "10.149.64.0/18"
        access                = "Allow"
        description           = "Allow connections from NV-Cyclers"
      },
    ])

    tags = {
      business-unit = "104 R&D AB"
      department    = "113049 P&L Facility - AB"
      cost-center   = "113049074 P&L Facility AB"
      project       = "P480-5"
    }
  }
)

