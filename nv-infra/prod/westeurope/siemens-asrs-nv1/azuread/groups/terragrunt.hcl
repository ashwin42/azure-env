terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//groups?ref=v1.3.2"
  #source = "../../../../../../../tf-mod-azuread/groups/"
}

# Include all settings from the root terragrunt.hcl file
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "sql_app" {
  config_path = "../../sql_app"
}

inputs = {
  groups = [
    {
      display_name     = "Siemens ASRS Administrators"
      description      = "Members in this group gets Administrator access to Siemens ASRS WCS system"
      security_enabled = true
      member_users     = ["Mihajlo.manojlov@northvolt.com"]
    },
    {
      display_name     = "Siemens ASRS Users"
      description      = "Members in this group gets User access to Siemens ASRS WCS system"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "Siemens ASRS Database Administrators"
      description      = "Members in this group get administrator access to ASRS Azure SQL Server"
      security_enabled = true
      member_users     = []
      object_ids       = [dependency.sql_app.outputs.service_principal_object_id]
    },
  ]
}

