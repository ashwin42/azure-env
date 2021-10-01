terraform {
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  groups = [
    {
      display_name = "Siemens ASRS Administrators"
      description  = "Members in this group gets Administrator access to Siemens ASRS WCS system"
      members      = ["Mihajlo.manojlov@northvolt.com"]
    },
    {
      display_name = "Siemens ASRS Users"
      description  = "Members in this group gets User access to Siemens ASRS WCS system"
      members      = []
    },
  ]
}

