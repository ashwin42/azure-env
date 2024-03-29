terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//groups?ref=v1.1.0"
  #source = "${dirname(get_repo_root())}/tf-mod-azuread/groups/"
}

# Include all settings from the root terragrunt.hcl file
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  groups = [
    {
      display_name     = "Physical Security ARX Users"
      description      = "Provides User access to ARX System"
      security_enabled = true
      member_groups    = []
    },
  ]
}

