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
      display_name = "AWS Synaos Admins"
      description  = "Provides Administrator access to AWS avl-prod and avl-dev accounts"
      security_enabled = true
    },
    {
      display_name = "AWS Synaos Developers"
      description  = "Provides Administrator access to AWS avl-dev account"
      security_enabled = true
    },
#    {
#      display_name = "Synaos Users"
#      description  = "Synaos non-NV users"
#      security_enabled = true
#    },
    {
      display_name = "AWS Synaos Admins VPN AP"
      description  = "Provides VPN access to Synaos prod resources in cloud and on-prem"
      security_enabled = true
    },
    {
      display_name = "AWS Synaos Developers VPN AP"
      description  = "Provides VPN access to Synaos dev resources in cloud and on-prem"
      security_enabled = true
    },
  ]
}

