terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//mssql?ref=v0.7.22"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//mssql"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  name                          = "nvataccamamasterdatadev"
  key_vault_name                = "nv-infra-core"
  key_vault_rg                  = "nv-infra-core"
  minimum_tls_version           = "1.2"
  create_administrator_password = true
  public_network_access_enabled = true
  lock_resources                = false 
  azuread_administrator = {
    group = "NV TechOps Consultants Member"
  }
  databases = [
    {
      name                        = "masterdatatransfdev"
      sku_name                    = "GP_S_Gen5_1"
      min_capacity                = "0.5"
      max_size_gb                 = "50"
      auto_pause_delay_in_minutes = "60"
    },
    {
      name                        = "ivaluadev"
      max_size_gb                 = "50"
    }
  ]  
}
