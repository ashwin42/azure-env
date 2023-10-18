terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//groups?ref=v1.3.4"
  #source = "../../../../../../../tf-mod-azuread/groups/"
}

# Include all settings from the root terragrunt.hcl file
include "root" {
  path   = find_in_parent_folders()
  expose = true
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
      display_name     = "NV TIA-MU-VPN AP"
      description      = "Used in access package, do not modify. Members in this group obtain VPN access to TIA MU Servers and PLCs"
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
      display_name     = "TIA MU mPlus VPN Users"
      description      = "Used in access package, do not modify. Members in this group obtain access to TIA MU mPlus Server"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "TIA MU PNE Approvers"
      description      = "Used in access package, do not modify. Members in this group will approve TIA MU PNE Server requests"
      security_enabled = true
      member_users     = ["hamed@northvolt.com", "maria.chun@northvolt.com"]
    },
    {
      display_name     = "TIA MU PNE VPN Users"
      description      = "Used in access package, do not modify. Members in this group obtain access to TIA MU PNE Server"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "TIA MU Munters Approvers"
      description      = "Used in access package, do not modify. Members in this group will approve TIA MU Munters Server requests"
      security_enabled = true
      member_users     = ["hamed@northvolt.com", "maria.chun@northvolt.com"]
    },
    {
      display_name     = "TIA MU Munters VPN Users"
      description      = "Used in access package, do not modify. Members in this group obtain access to TIA MU Munters Server"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "TIA MU DEC Approvers"
      description      = "Used in access package, do not modify. Members in this group will approve TIA MU Dec Server requests"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "TIA MU DEC VPN Users"
      description      = "Used in access package, do not modify. Members in this group obtain access to TIA MU Dec Server"
      security_enabled = true
      member_users     = []
    },
    ### Hanwha    
    {
      display_name     = "TIA MU Hanwha Approvers"
      description      = "Used in access package, do not modify. Members in this group will approve TIA MU Hanwha Server requests"
      security_enabled = true
      member_users     = ["c.david.gunstad@northvolt.com", "hamed@northvolt.com", "anton.frankel@northvolt.com"]
    },
    {
      display_name     = "TIA MU Hanwha VPN Users"
      description      = "Used in access package, do not modify. Members in this group obtain access to TIA MU Hanwha Server"
      security_enabled = true
      member_users     = []
    },
  ]
}

