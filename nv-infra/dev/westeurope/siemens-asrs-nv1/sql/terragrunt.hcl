terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//mssql?ref=v0.7.17"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//mssql"
}

dependency "global" {
  config_path = "../global"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name           = dependency.global.outputs.resource_group.name
  setup_prefix                  = dependency.global.outputs.setup_prefix
  key_vault_name                = "nv-infra-core"
  key_vault_rg                  = "nv-infra-core"
  lock_resources                = false
  public_network_access_enabled = false
  azuread_administrator = {
    username = "domainjoin@northvolt.com"
  }
  databases = [
    {
      name     = "siemens-asrs-wcs-dev-1"
      max_size = "2147483648"
      edition  = "Basic"
    },
  ]
  custom_rules = [
    {
      name      = "AllowLocalSubnet"
      subnet_id = dependency.global.outputs.subnet["asrs-nv1-dev-subnet-10.44.5.176-28"].id
    }
  ]
  private_endpoints = {
    "asrs-nv1-dev-pe" = {
      subnet_id = dependency.global.outputs.subnet["asrs-nv1-dev-subnet-10.44.5.176-28"].id
      private_service_connection = {
        name              = "asrs-nv1-dev-pec"
        subresource_names = ["sqlServer"]
      }
      create_dns_record            = true
      dns_zone_name                = "privatelink.database.windows.net"
      dns_zone_resource_group_name = "core_network"
      dns_record_name              = "asrs-nv1-dev-sql"
      dns_zone_subscription_id     = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
      dns_record_ttl               = 300
    }
  }
}
