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
  web_app_vnet_integration_subnet_id = dependency.global.outputs.subnet["${local.name}-web-app-subnet"].id

  private_endpoint = {
    location            = include.root.locals.all_vars.location
    subnet_id           = dependency.global.outputs.subnet["asrs-nv1-prod-subnet-10.46.0.0-27"].id
    resource_group_name = dependency.global.outputs.resource_group.name
    private_service_connection = {
      name                 = "${dependency.global.outputs.setup_prefix}-pec"
      subresource_names    = ["sites"]
      is_manual_connection = false
    }
  }

  iam_assignments = {
    Contributor = {
      groups = [
        "AAD-Siemens-ASRS-VPN-AP",
      ],
    }
  }
}
