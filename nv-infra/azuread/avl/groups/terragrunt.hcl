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
      display_name = "AWS AVL Admins"
      description  = "Provides Administrator access to AWS avl-prod and avl-dev accounts"
      security_enabled = true
    },
    {
      display_name = "AWS AVL Developers"
      description  = "Provides Administrator access to AWS avl-dev account"
      security_enabled = true
    },
    {
      display_name = "AVL Users"
      description  = "AVL non-NV users"
      security_enabled = true
    },
    {
      display_name = "AWS AVL Admins VPN AP"
      description  = "Provides VPN access to AVL prod resources in cloud and on-prem"
      security_enabled = true
    },
    {
      display_name = "AWS AVL Developers VPN AP"
      description  = "Provides VPN access to AVL dev resources in cloud and on-prem"
      security_enabled = true
    },
    {
      display_name = "AVL A&PC Administrator"
      description = "Full access"
      security_enabled = true
    },
    {
      display_name = "AVL A&PC User"
      description = "Read only access"
      security_enabled = true
    },
    {
      display_name = "AVL A&PC Lab engineer"
      description = "Action table"
      security_enabled = true
    },
    {
      display_name = "AVL A&PC Work order manager"
      description = "Project Manager, Planner and Test Methodologist activities"
      security_enabled = true
    },
    {
      display_name = "AVL A&PC Project EV32"
      description = ""
      security_enabled = true
    },
    {
      display_name = "AVL A&PC Project PPE Slim"
      description = ""
      security_enabled = true
    },
    {
      display_name = "AVL A&PC Project PPE High"
      description = ""
      security_enabled = true
    },
    {
      display_name = "AVL A&PC Project PPE CV"
      description = ""
      security_enabled = true
    },
    {
      display_name = "AVL A&PC Project PPE CV ESS"
      description = ""
      security_enabled = true
    },
    {
      display_name = "AVL A&PC Project UC"
      description = ""
      security_enabled = true
    },
    {
      display_name = "AVL A&PC Project GPA"
      description = ""
      security_enabled = true
    },
    {
      display_name = "AVL A&PC Project L1"
      description = ""
      security_enabled = true
    },
    {
      display_name = "AVL A&PC Project P1"
      description = ""
      security_enabled = true
    },
    {
      display_name = "AVL A&PC Project L2"
      description = ""
      security_enabled = true
    },
    {
      display_name = "AVL A&PC Project 46/80"
      description = ""
      security_enabled = true
    },
    {
      display_name = "AVL AP Eligible Users"
      description = "Provides eligibility to request accees to AVL A&PC Access Packages"
      security_enabled = true
    },
  ]
}

