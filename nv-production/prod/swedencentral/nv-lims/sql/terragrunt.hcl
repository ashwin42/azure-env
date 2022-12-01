terraform {
  source = "git@github.com:northvolt/tf-mod-azure.git//mssql?ref=v0.7.18"
  # source = "../../../../../../tf-mod-azure/sql"
}

dependency "vnet" {
  config_path = "../subnet"
}


# Include all settings from the root terragrunt.hcl file
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  key_vault_name = "nv-production-core"
  key_vault_rg   = "nv-production-core"
  subnet_id      = dependency.vnet.outputs.subnet["nv-lims-subnet-10.64.1.32_27"].id
  lock_resources = false
  azuread_administrator = {
    username = "domainjoin@northvolt.com"
  }
  create_administrator_password = true
  private_endpoints = {
    "nv-lims-pe" = {
      subnet_id = dependency.vnet.outputs.subnet["nv-lims-subnet-10.64.1.32_27"].id
      private_service_connection = {
        name              = "nv-lims-pec"
        subresource_names = ["sqlServer"]
      }
      private_dns_zone_group = {
        name                         = "nv-lims-sql"
        dns_zone_resource_group_name = "core_network"
        dns_zone_name                = "privatelink.database.windows.net"
        dns_zone_subscription_id     = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
        dns_record_ttl               = 300
      }
    }
  }
  custom_rules = [
    {
      name      = "AllowLocalSubnet"
      subnet_id = dependency.vnet.outputs.subnet["nv-lims-subnet-10.64.1.32_27"].id
    }
  ]
}
