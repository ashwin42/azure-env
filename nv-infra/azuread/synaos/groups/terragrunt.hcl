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
      display_name     = "AWS Synaos Admins"
      description      = "Provides Administrator access to AWS synaos-prod and synaos-dev accounts"
      security_enabled = true
    },
    {
      display_name     = "AWS Synaos Developers"
      description      = "Provides Administrator access to AWS synaos-dev account"
      security_enabled = true
    },
    {
      display_name     = "Synaos Administrators"
      description      = "Synaos system administrators"
      security_enabled = true
    },
    {
      display_name     = "Synaos Users"
      description      = "Synaos system users"
      security_enabled = true
    },
    {
      display_name     = "AWS Synaos Admins VPN AP"
      description      = "DO NOT EDIT. Provides VPN access to Synaos prod resources in cloud and on-prem"
      security_enabled = true
    },
    {
      display_name     = "AWS Synaos Developers VPN AP"
      description      = "DO NOT EDIT. Provides VPN access to Synaos dev resources in cloud and on-prem"
      security_enabled = true
    },
  ]
}

