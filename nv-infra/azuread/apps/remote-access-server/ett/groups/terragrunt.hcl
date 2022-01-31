terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//groups?ref=v1.0.0"
  #source = "../../../../../tf-mod-azuread/groups/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  groups = [
    {
      display_name = "Remote Access Server Umbrella Group Ett"
      description  = "Groups assigned to this group will be synced to remote access server ett database"
      security_enabled = true
    },
  ]
}

