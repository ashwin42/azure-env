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
      display_name = "Toolsnet VPN AP"
      description  = "Members in this group gets access to Toolsnet VPN"
      security_enabled = true
      member_users      = []
    },
  ]
}

