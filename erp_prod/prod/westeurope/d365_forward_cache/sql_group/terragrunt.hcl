terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//groups?ref=v1.3.1"
  #source = "../../../../../../tf-mod-azuread/groups/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "sql_app" {
  config_path = "../sql_app"
}

inputs = {
  groups = [
    {
      display_name     = "NV D365 Forward Cache VPN AP"
      description      = "Members in this group get VPN Access to d365_forward_cache Azure SQL Server"
      security_enabled = true
    },
    {
      display_name     = "NV D365 Forward Cache Administrator Access"
      description      = "Members in this group get administrator access to d365_forward_cache Azure SQL Server"
      security_enabled = true
      member_users     = []
      object_ids       = [dependency.sql_app.outputs.service_principal_object_id]
    },
    {
      display_name     = "NV D365 Forward Cache User Access to d365_forward_cache DB"
      description      = "Members in this group get user access to d365_forward_cache Azure SQL DB"
      security_enabled = true
    },
  ]
}

