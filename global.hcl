locals {
  billing_account_name = "9c287b6b-17b0-503d-d8dc-eb9bcdb496c6:7e9d861d-4e15-4889-aa22-7f096c727adc_2019-05-31"
  billing_profile_name = "PQSA-I454-BG7-PGB"
  invoice_section_name = "E5XA-OC4Y-PJA-PGB"
  account_type         = "customer"
  dns_servers          = ["10.40.250.4", "10.40.250.5"]
  vpn_subnet_labs      = "10.16.8.0/23"
  vpn_subnet_ett       = "10.240.0.0/21"

  # module versions
  tf_mod_azuread_app_version    = "v1.3.2"
  tf_mod_azuread_groups_version = "v1.3.2"
  tf_mod_azure_sql_version      = "v0.6.13" # "v0.7.0"
  tf_mod_azure_global_version   = "v0.6.13"
}
