terraform {
  source = "git@github.com:northvolt/tf-mod-azure.git//sql?ref=v0.7.5"
  # source = "../../../../../../tf-mod-azure/sql"
}

dependency "global" {
  config_path = "../global"
}

dependency "sql_app" {
  config_path = "../sql_app"
}


# Include all settings from the root terragrunt.hcl file
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  resource_group_name     = dependency.global.outputs.resource_group.name
  setup_prefix            = dependency.global.outputs.setup_prefix
  key_vault_name          = "nv-infra-core"
  key_vault_rg            = "nv-infra-core"
  subnet_id               = dependency.global.outputs.subnet["asrs-nv1-prod-subnet-10.46.0.0-27"].id
  create_private_endpoint = true
  lock_resources          = false
  minimum_tls_version     = "Disabled"
  ad_admin_login_group    = "Siemens ASRS Database Administrators"
  databases = [
    {
      name = "siemens-wcs-cathode"
    },
    {
      name = "siemens-wcs-anode"
    },
    {
      name = "siemens-wcs-cw1"
    },
    {
      name = "siemens-wcs-fa1"
    },
    {
      name = "siemens-wcs-spw"
    },
    {
      name = "siemens-wcs-cathode2"
    },
    {
      name = "siemens-wcs-anode2"
    },
  ]
  mssql_user_client_id     = dependency.sql_app.outputs.client_id
  mssql_user_client_secret = dependency.sql_app.outputs.service_principal_password
  mssql_azuread_users = [
    {
      username = "AAD-Siemens-ASRS-VPN-AP"
      roles    = ["db_owner"]
      database = "siemens-wcs-cathode2"
    },
    {
      username = "NV TechOps Role"
      roles    = ["db_owner"]
      database = "siemens-wcs-cathode2"
    },
    {
      username = "AAD-Siemens-ASRS-VPN-AP"
      roles    = ["db_owner"]
      database = "siemens-wcs-anode2"
    },
    {
      username = "NV TechOps Role"
      roles    = ["db_owner"]
      database = "siemens-wcs-anode2"
    },
  ]
  mssql_local_users = [
    {
      username      = "asrs_wcs_rw_user"
      roles         = ["db_datawriter"]
      database      = "siemens-wcs-cathode2"
      create_secret = true
    },
    {
      username      = "asrs_wcs_ro_user"
      roles         = ["db_datareader"]
      database      = "siemens-wcs-cathode2"
      create_secret = true
    },
    {
      username      = "asrs_wcs_rw_user"
      roles         = ["db_datawriter"]
      database      = "siemens-wcs-anode2"
      create_secret = true
    },
    {
      username      = "asrs_wcs_ro_user"
      roles         = ["db_datareader"]
      database      = "siemens-wcs-anode2"
      create_secret = true
    },
  ]

  custom_rules = [
    {
      name      = "AllowLocalSubnet"
      subnet_id = dependency.global.outputs.subnet["asrs-nv1-prod-subnet-10.46.0.0-27"].id
    }
  ]
}
