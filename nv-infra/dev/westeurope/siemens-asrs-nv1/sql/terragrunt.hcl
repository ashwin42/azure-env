terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//sql?ref=v0.4.0"
  #source = "../../../../../../tf-mod-azure/sql"
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
  subnet_id                     = dependency.global.outputs.subnet["asrs-nv1-dev-subnet-10.44.5.176-28"].id
  create_private_endpoint       = true
  lock_resources                = false
  public_network_access_enabled = false
  ad_admin_login                = "domainjoin@northvolt.com"
  ad_admin_login_object_id      = "3abb8eea-ad26-4e7d-9d7d-677ce9b8df0f"
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
}
