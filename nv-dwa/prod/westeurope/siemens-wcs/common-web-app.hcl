include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "subnet" {
  config_path = "./subnet"
}

dependency "resource_group" {
  config_path = "./resource_group"
}

locals {
  name         = replace(basename(get_original_terragrunt_dir()), "web_app-", "")
  setup_prefix = "dwa-wcs-${local.name}"
}

inputs = {
  setup_prefix        = local.setup_prefix
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
  web_app_vnet_integration_subnet_id = dependency.subnet.outputs.subnets["${include.root.locals.all_vars.project}-web-app-${local.name}"].id

  private_endpoint = {
    location            = include.root.locals.all_vars.location
    subnet_id           = dependency.subnet.outputs.subnets["${include.root.locals.all_vars.project}-subnet1"].id
    resource_group_name = dependency.resource_group.outputs.resource_group_name
    private_dns_zone_group = {
      dns_zone_resource_group_name = "core_network"
      dns_zone_name                = "privatelink.azurewebsites.net"
      dns_zone_subscription_id     = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
    }
    private_service_connection = {
      name                 = "${include.root.locals.all_vars.project}-pec"
      subresource_names    = ["sites"]
      is_manual_connection = false
    }
  }

  iam_assignments = {
    Contributor = {
      groups = [
        "VPN-Siemens-ASRS-AP",
      ],
    }
  }
}
