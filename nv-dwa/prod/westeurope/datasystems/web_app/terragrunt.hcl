terraform {
  source = "git@github.com:northvolt/tf-mod-azure.git//web_app?ref=v0.10.8"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//web_app/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "subnet" {
  config_path = "../../strama-lds/subnet/"
}

dependency "resource_group" {
  config_path = "../resource_group"
}

locals {
  name = "dwa-lds-${include.root.locals.all_vars.project}"
}

inputs = {
  setup_prefix        = local.name
  resource_group_name = dependency.resource_group.outputs.resource_group_name

  os_type    = "Linux"
  sku_name   = "P1v2"
  https_only = true

  site_config = {
    always_on          = true
    use_32_bit_worker  = true
    websockets_enabled = true
    ftps_state         = "FtpsOnly"
    application_stack = {
      python_version = "3.11"
    }
    app_command_line = "gunicorn --bind=0.0.0.0 index:server --log-level=debug --capture-output --access-logfile='-' --error-logfile='-'"
  }

  app_settings = {
    SCM_DO_BUILD_DURING_DEPLOYMENT = "true"
    "APP_USERNAME"                 = "Shahin Ghazinouri"
    "PYTHONUNBUFFERED"             = 1
  }

  logs = {
    detailed_error_messages = false
    failed_request_tracing  = false

    http_logs = {
      file_system = {
        retention_in_days = 3
        retention_in_mb   = 35
      }
    }
  }

  virtual_network_subnet_id = dependency.subnet.outputs.subnets["strama-lds-${include.root.locals.all_vars.project}-web-app"].id

  private_endpoint_dns_zone_subscription_id = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
  private_endpoints = [
    {
      name      = "dwa-lds-datasystems-pe"
      subnet_id = dependency.subnet.outputs.subnets["strama-lds-subnet1"].id
      private_dns_zone_group = {
        dns_zone_resource_group_name = "core_network"
        dns_zone_name                = "privatelink.azurewebsites.net"
      }
      private_service_connection = {
        name = "${include.root.locals.all_vars.project}-pec"
      }
    },
  ]

  iam_assignments = {
    Contributor = {
      groups = [
        "VPN Dwa DataSystems Python VM AP",
      ],
    }
  }
}
