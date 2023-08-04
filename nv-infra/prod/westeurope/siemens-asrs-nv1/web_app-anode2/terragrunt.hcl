terraform {
  source = "git@github.com:northvolt/tf-mod-azure.git//web_app?ref=v0.7.62"
  # source = "${dirname(get_repo_root())}/tf-mod-azure/web_app/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common-asrs-web-app.hcl"))
}

inputs = merge(
  local.common.inputs,
  {
    client_affinity_enabled = true
    client_certificate_mode = "Required"
    app_settings = {
      WEBSITE_CONFIGURATION_READY      = "1"
      WEBSITE_CORS_SUPPORT_CREDENTIALS = "False"
    }
    site_config = {
      ftps_state         = "AllAllowed"
      websockets_enabled = true
      always_on          = true
      use_32_bit_worker  = true
      application_stack = {
        dotnet_version = "v6.0"
        current_stack  = "dotnet"
      }
    }
  }
)


