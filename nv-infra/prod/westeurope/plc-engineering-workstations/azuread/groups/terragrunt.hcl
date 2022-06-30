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
      display_name     = "Labs FL.P1 Workstation Access"
      description      = "Members in this group gets VPN access to PLC Engineering Workstation 01 - FL.P1"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "Labs FL.F1 Workstation Access"
      description      = "Members in this group gets VPN access to PLC Engineering Workstation 02 - FL.F1"
      security_enabled = true
      member_users     = []
    },
    {
      display_name     = "Labs FL.A1 & FL.C1 Workstation Access"
      description      = "Members in this group gets VPN access to PLC Engineering Workstation 03 - FL.A1 & FL.C1"
      security_enabled = true
      member_users     = []
    },
  ]
}

