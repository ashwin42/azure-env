include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "./vnet"
}

locals {
  name = replace(basename(get_original_terragrunt_dir()), "web_app-", "")
}

inputs = {
  setup_prefix                  = "asrs-nv1-prod-${local.name}"
  public_network_access_enabled = true
  os_type                       = "Windows"
  sku_name                      = "P1v2"
  https_only                    = true

  site_config = {
    ftps_state         = "AllAllowed"
    websockets_enabled = true
    always_on          = true
    use_32_bit_worker  = true
  }
  client_certificate_mode = "Optional"

  virtual_network_subnet_id = dependency.vnet.outputs.subnets["${local.name}-web-app-subnet"].id

  private_endpoint = {
    location            = include.root.locals.all_vars.location
    subnet_id           = dependency.vnet.outputs.subnets["asrs-nv1-prod-subnet-10.46.0.0-27"].id
    resource_group_name = include.root.locals.all_vars.resource_group_name
    private_dns_zone_group = {
      dns_zone_resource_group_name = "core_network"
      dns_zone_name                = "privatelink.azurewebsites.net"
      dns_zone_subscription_id     = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
    }
    private_service_connection = {
      name                 = "asrs-nv1-prod-pec"
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
