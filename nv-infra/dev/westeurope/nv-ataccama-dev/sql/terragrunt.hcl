terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//mssql?ref=v0.7.18"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//mssql"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  key_vault_name                = "nv-infra-core"
  key_vault_rg                  = "nv-infra-core"
  minimum_tls_version           = "1.2"
  create_administrator_password = true
  public_network_access_enabled = true 
  azuread_administrator = {
    group = "NV TechOps Consultants Member"
  }
  databases = [
    {
      name     = "nv-ataccama-dev"
      sku_name = "GP_S_Gen5_1"
    },
  ]
  custom_rules = [
    {
      name             = "Sumit's test IP"
      start_ip_address = "205.254.163.130"
    },    
  ]
}
