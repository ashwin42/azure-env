terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//groups?ref=v1.4.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azuread/groups/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  groups = [
    {
      display_name     = "Cuberg APIS IQ User Access"
      description      = "Members in this group gets access to Cuberg APIS IQ Virtual Desktop"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "Cuberg APIS IQ AP Approvers"
      description      = "Members in this group can approve requests for Cuberg APIS IQ AP"
      security_enabled = true
      member_users     = []
    },
  ]
}

