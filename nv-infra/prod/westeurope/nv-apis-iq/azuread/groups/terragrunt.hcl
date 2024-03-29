terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//groups?ref=v1.6.8"
  #source = "${dirname(get_repo_root())}/tf-mod-azuread/groups/"
}

# Include all settings from the root terragrunt.hcl file
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  groups = [
    {
      display_name     = "APIS IQ User Access"
      description      = "Members in this group gets access to APIS IQ cloud setup WVD and VPN"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "APIS IQ AP Approvers"
      description      = "Members in this group can approve requests for APIS IQ AP"
      security_enabled = true
      member_users     = ["noemi.kiss@northvolt.com", "jesper.adolfsson@northvolt.com", "Aleksandra.Roszkowska@northvolt.com"]
    },
  ]
}

