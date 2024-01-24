terraform {
  source = "git@github.com:northvolt/tf-mod-azure.git//mssql?ref=v0.10.13"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//mssql"
}

dependency "vnet" {
  config_path = "../vnet"
}

dependency "sql_app" {
  config_path = "../sql_app"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  name                  = "asrs-nv1-prod-sql"
  secret_name           = "asrs-nv1-prod-sqladmin"
  mssql_app_login       = true
  mssql_federated_login = false
  key_vault_name        = "nv-infra-core"
  key_vault_rg          = "nv-infra-core"

  private_endpoints = [
    {
      name      = "asrs-nv1-prod-pe"
      subnet_id = dependency.vnet.outputs.subnets["asrs-nv1-prod-subnet-10.46.0.0-27"].id
      private_service_connection = {
        name              = "asrs-nv1-prod-pec"
        subresource_names = ["sqlServer"]
      }
      create_dns_record            = true
      dns_zone_name                = "privatelink.database.windows.net"
      dns_zone_resource_group_name = "core_network"
    }
  ]

  lock_resources      = false
  minimum_tls_version = "Disabled"

  azuread_administrator = {
    group = "Siemens ASRS Database Administrators"
  }

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
      username = "VPN Siemens ASRS AP"
      roles    = ["db_owner"]
      database = "siemens-wcs-cathode2"
    },
    {
      username = "NV TechOps Role"
      roles    = ["db_owner"]
      database = "siemens-wcs-cathode2"
    },
    {
      username = "VPN Siemens ASRS AP"
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
      subnet_id = dependency.vnet.outputs.subnets["asrs-nv1-prod-subnet-10.46.0.0-27"].id
    }
  ]
}

