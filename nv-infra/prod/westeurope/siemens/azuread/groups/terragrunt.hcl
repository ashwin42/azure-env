terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//groups?ref=v1.1.0"
  #source = "../../../../../../../tf-mod-azuread/groups/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  groups = [
    {
      display_name     = "Physical Security Administrators"
      description      = "Provides Administrator access to Physical Security Systems"
      security_enabled = true
      member_groups    = []
      member_users    = []      
    },
    {
      display_name     = "Physical Security Access Users"
      description      = "Provides User access to Physical Security Systems"
      security_enabled = true
      member_groups    = []
      member_users    = []            
    },
    {
      display_name     = "Physical Security CCTV Users"
      description      = "Provides User access to CCTV Systems"
      security_enabled = true
      member_groups    = []
      member_users    = []            
    },
    {
      display_name     = "Physical Security Server Administrators"
      description      = "Provides Administrator access to Physical Security servers"
      security_enabled = true
      member_groups    = []
      member_users    = []            
    },
    {
      display_name     = "Desigo RND2.0 VPN AP"
      description      = "Provides Administrator access to Desigo RND2.0"
      security_enabled = true
      member_groups    = []
      member_users    = []            
    },
    {
      display_name     = "Desigo RND2.0 VPN AP Approvers"
      description      = "Approvers for Desigo RND2.0 VPN AP"
      security_enabled = true
      member_groups    = []      
      member_users    = ["karel.silha@northvolt.com"]
    },    
  ]
}

