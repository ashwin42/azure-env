terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//groups?ref=v1.3.0"
  #source = "../../../../../../../tf-mod-azuread/groups/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  groups = [
    {
      display_name     = "Labx Ett Users"
      description      = "Used in access package, do not modify. Members in this group obtain access to the LabX Ett WVD"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "LabX-Users"
      description      = "Used in access package, do not modify. Members in this group obtain access to the LabX Labs QC WVD"
      security_enabled = true
      member_users     = []
    },
  ]
}

