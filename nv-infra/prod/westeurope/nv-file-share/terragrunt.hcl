terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.7.44"
  #source = "../../../../../tf-mod-azure//storage/"
}

dependency "global" {
  config_path = "../vnet"
}

dependency "e3-global" {
  config_path = "../nv-e3/global"
}

dependency "labx-global" {
  config_path = "../nv-labx/vnet/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name                              = "nvinfrafs"
  resource_group_name               = dependency.global.outputs.resource_group.name
  location                          = dependency.global.outputs.resource_group.location
  enable_advanced_threat_protection = false
  min_tls_version                   = "TLS1_0"
  allow_nested_items_to_be_public   = false
  blob_properties = {
    versioning_enabled = true
    delete_retention_policy = {
      days = 30
    }
    container_delete_retention_policy = {
      days = 30
    }
  }


  azure_files_authentication = {
    directory_type = "AADDS"
  }

  identity = {
    type = "SystemAssigned"
  }

  file_shares = [
    { name = "e3-battery-systems", quota = 10 },
    { name = "e3-labs-maintenance", quota = 10 },
    { name = "labware-8", quota = 10 },
  ]

  network_rules = {
    default_action = "Deny"
    bypass         = ["AzureServices"]
    virtual_network_subnet_ids = [
      dependency.e3-global.outputs.subnet["nv-e3-subnet-10.44.5.128"].id,
      dependency.labx-global.outputs.subnets.labx_subnet.id
    ]
  }

  private_endpoints = {
    "nvinfrafs-pe" = {
      subnet_id = dependency.global.outputs.subnet.vdi_subnet.id
      private_service_connection = {
        subresource_names = ["file"]
      }
      private_dns_zone_group = {
        name                         = "default"
        dns_zone_resource_group_name = "nv_infra"
        dns_zone_name                = "privatelink.file.core.windows.net"
      }
    }
  }
}
