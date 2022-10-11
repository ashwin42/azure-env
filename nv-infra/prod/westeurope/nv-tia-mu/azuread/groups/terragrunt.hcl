terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//groups?ref=v1.3.4"
  #source = "../../../../../../../tf-mod-azuread/groups/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  groups = [
    {
      display_name     = "TIA MU Administrators"
      description      = "Used in access package, do not modify. Members in this group obtain admin access to TIA MU Servers"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "TIA MU VPN AP"
      description      = "Used in access package, do not modify. Members in this group obtain VPN access to TIA MU Servers"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "TIA MU Strama Approvers"
      description      = "Used in access package, do not modify. Members in this group will approve TIA MU Strama Server requests"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "TIA MU Strama Users"
      description      = "Used in access package, do not modify. Members in this group obtain access to TIA MU Strama Server"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "TIA MU mPlus Approvers"
      description      = "Used in access package, do not modify. Members in this group will approve TIA MU mPlus Server requests"
      security_enabled = true
      member_users     = ["hamed@northvolt.com", "anton.frankel@northvolt.com", "c.pablo.gijon@northvolt.com"]
    },
    {
      display_name     = "TIA MU mPlus Users"
      description      = "Used in access package, do not modify. Members in this group obtain access to TIA MU mPlus Server"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "TIA MU PNE Approvers"
      description      = "Used in access package, do not modify. Members in this group will approve TIA MU mPlus Server requests"
      security_enabled = true
      member_users     = ["hamed@northvolt.com", "maria.chun@northvolt.com"]
    },
    {
      display_name     = "TIA MU PNE Users"
      description      = "Used in access package, do not modify. Members in this group obtain access to TIA MU mPlus Server"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "TIA MU Munters Approvers"
      description      = "Used in access package, do not modify. Members in this group will approve TIA MU mPlus Server requests"
      security_enabled = true
      member_users     = ["hamed@northvolt.com", "maria.chun@northvolt.com"]
    },
    {
      display_name     = "TIA MU Munters Users"
      description      = "Used in access package, do not modify. Members in this group obtain access to TIA MU mPlus Server"
      security_enabled = true
      member_users     = []
    },    
  ]
}

