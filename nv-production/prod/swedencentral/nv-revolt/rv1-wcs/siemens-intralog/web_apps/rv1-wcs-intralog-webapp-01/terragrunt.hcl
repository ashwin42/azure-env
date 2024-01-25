terraform {
  source = "git@github.com:northvolt/tf-mod-azure.git//web_app?ref=v0.10.14"
  # source = "${dirname(get_repo_root())}/tf-mod-azure//web_app/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "subnet" {
  config_path = "../../subnet"
}

dependency "resource_group" {
  config_path = "../../resource_group"
}

locals {
  name                = basename(get_terragrunt_dir())
  subnet              = "revolt-wcs-web-app-01"
  intergration_subnet = "revolt-wcs-subnet-01"
}

inputs = {
  setup_prefix        = local.name
  resource_group_name = dependency.resource_group.outputs.resource_group_name

  os_type    = "Windows"
  sku_name   = "P1v2"
  https_only = true

  app_settings = {
    "ASPNETCORE_DETAILEDERRORS" = "true"
  }

  site_config = {
    always_on          = true
    use_32_bit_worker  = true
    ftps_state         = "AllAllowed"
    websockets_enabled = true
    application_stack = {
      dotnet_version = "v6.0"
    }
  }

  client_certificate_mode = "Optional"

  virtual_network_subnet_id = dependency.subnet.outputs.subnets[local.subnet].id

  private_endpoints = [
    {
      name      = "${local.name}-pe"
      subnet_id = dependency.subnet.outputs.subnets[local.intergration_subnet].id
      private_service_connection = {
        name                 = "${local.name}-pec"
        subresource_names    = ["sites"]
        is_manual_connection = false
      }
      private_dns_zone_group = {
        dns_zone_resource_group_name = "core_network"
        dns_zone_name                = "privatelink.azurewebsites.net"
      }
    }
  ]

  iam_assignments = {
    Contributor = {
      groups = [
        "VPN Revolt Siemens WCS AP",
        "VPN Siemens ASRS AP"
      ],
    }
  }
}

