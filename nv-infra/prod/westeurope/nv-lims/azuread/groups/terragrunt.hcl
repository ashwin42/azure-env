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
      display_name     = "Labware Users"
      description      = "Allow access to Labware Virtual Desktop"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "Labware LIMS Remote Desktop - reviewer"
      description      = "Contains reviewers for Labware LIMS Remote Desktop access package"
      security_enabled = true
      member_users     = []
    },
  ]
}
