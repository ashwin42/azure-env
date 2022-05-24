terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//groups?ref=v1.1.0"
  #source = "../../../../../../../tf-mod-azuread/groups/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  groups = [
    {
      display_name     = "P&L Validation Labs PNE Virtual Desktop users"
      description      = "P&L Validation Labs PNE Virtual Desktop users - TC1 - TC12"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "P&L Validation Labs Keysight Virtual Desktop users"
      description      = "P&L Validation Labs Keysight Virtual Desktop users - TC12"
      security_enabled = true
      member_users     = ["thobias.bohlin@northvolt.com", "c.stefan.nilsson@northvolt.com"]
    },
  ]
}

