terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//groups?ref=v1.0.0"
  #source = "../../../../../../../tf-mod-azuread/groups/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
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
  ]
}

