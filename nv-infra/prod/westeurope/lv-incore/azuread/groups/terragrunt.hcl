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
      display_name     = "LV Incore Administrators"
      description      = "Members in this group gets Administrator access to LV Incore system"
      security_enabled = true
      member_groups    = ["Techops"]
    },
    {
      display_name     = "LV Incore Users"
      description      = "Members in this group gets User access to LV Incore system"
      security_enabled = true
      member_groups    = []
    },
  ]
}

