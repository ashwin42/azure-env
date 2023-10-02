terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//groups?ref=v1.1.0"
  #source = "../../../../../../../tf-mod-azuread/groups/"
}

# Include all settings from the root terragrunt.hcl file
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  groups = [
    {
      display_name     = "ReVolt Wave4 WVD users"
      description      = "Used in access package. Don't use. Provides User access to ReVolt Wave4 Virtual Desktop"
      security_enabled = true
      member_groups    = []
    },
  ]
}

