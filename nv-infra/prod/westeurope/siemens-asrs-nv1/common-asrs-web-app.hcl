include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "global" {
  config_path = "./global"
}

locals {
  name = replace(basename(get_original_terragrunt_dir()), "web_app-", "")
}

inputs = {
  setup_prefix        = "${dependency.global.outputs.setup_prefix}-${local.name}"
  resource_group_name = dependency.global.outputs.resource_group.name

  os_type    = "Windows"
  sku_name   = "P1v2"
  https_only = true

  site_config = {
    ftps_state         = "AllAllowed"
    websockets_enabled = true
    always_on          = true
    use_32_bit_worker  = true
  }
  client_certificate_mode = "Optional"

  virtual_network_subnet_id = dependency.global.outputs.subnet["${local.name}-web-app-subnet"].id

  private_endpoint = {
    location            = include.root.locals.all_vars.location
    subnet_id           = dependency.global.outputs.subnet["asrs-nv1-prod-subnet-10.46.0.0-27"].id
    resource_group_name = dependency.global.outputs.resource_group.name
    private_dns_zone_group = {
      dns_zone_resource_group_name = "core_network"
      dns_zone_name                = "privatelink.azurewebsites.net"
      dns_zone_subscription_id     = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
    }
    private_service_connection = {
      name                 = "${dependency.global.outputs.setup_prefix}-pec"
      subresource_names    = ["sites"]
      is_manual_connection = false
    }
  }

  iam_assignments = {
    Contributor = {
      groups = [
        "VPN Siemens ASRS AP",
      ],
    }
  }
}
