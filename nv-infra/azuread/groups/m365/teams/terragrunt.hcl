terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//groups?ref=v1.1.0"
  #source = "../../../../../tf-mod-azuread/groups/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  groups = [
    {
      display_name            = "TechOps team"
      description             = "Northvolt TechOps team"
      provisioning_options    = ["Team"]
      visibility              = "Private"
      mail_enabled            = "true"
      mail_nickname           = "techops"
      types                   = ["Unified"]
    },
  ]
}
