terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//groups?ref=v1.1.0"
  #source = "../../../../../../tf-mod-azuread/groups/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  groups = [
    {
      display_name     = "Octoplant Labs VPN AP"
      description      = "Members in this group gets VPN access to Labs Labs"
      security_enabled = true
      member_users     = []
    },
  ]
}

