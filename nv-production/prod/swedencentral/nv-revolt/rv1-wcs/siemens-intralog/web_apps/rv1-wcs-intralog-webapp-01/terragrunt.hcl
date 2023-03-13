terraform {
  source = "git@github.com:northvolt/tf-mod-azure.git//web_app?ref=v0.7.39"
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

  settings = {
    site_config = {
      always_on         = true
      use_32_bit_worker = true
      application_stack = {
        dotnet_version = "v4.0"
      }
    }
  }

  web_app_vnet_integration_enabled   = true
  web_app_vnet_integration_subnet_id = dependency.subnet.outputs.subnets["${local.subnet}"].id

  private_endpoint = {
    location            = include.root.locals.all_vars.location
    subnet_id           = dependency.subnet.outputs.subnets["${local.intergration_subnet}"].id
    resource_group_name = dependency.resource_group.outputs.resource_group_name
    private_dns_zone_group = {
      dns_zone_resource_group_name = "core_network"
      dns_zone_name                = "privatelink.azurewebsites.net"
      dns_zone_subscription_id     = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
    }
    private_service_connection = {
      name                 = "${local.name}-pec"
      subresource_names    = ["sites"]
      is_manual_connection = false
    }
  }

  iam_assignments = {
    Contributor = {
      groups = [
        "VPN Revolt Siemens WCS AP",
      ],
    }
  }
}
