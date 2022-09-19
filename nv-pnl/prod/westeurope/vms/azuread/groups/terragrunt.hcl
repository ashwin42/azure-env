terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//groups?ref=v1.3.1"
  #source = "../../../../../../../tf-mod-azuread/groups/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  groups = [
    {
      display_name     = "P&L Validation Labs PNE VM Admins"
      description      = "P&L Validation Labs PNE VM Admins - TC1 - TC12"
      security_enabled = true
      member_users     = []
    },
  ]
}

