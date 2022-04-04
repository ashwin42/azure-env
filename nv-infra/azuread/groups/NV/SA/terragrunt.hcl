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
      display_name            = "NV SA F1 Mevisio access"
      description             = "Group to grant service accounts access to Mevisio Enterprise app at NV1"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(user.userPrincipalName -startsWith \"sa-f1.\") and (user.userType -eq \"member\") and (user.accountEnabled -eq true) and (user.companyName -contains \"Mevisio\")"
    },
    {
      display_name            = "NV SA F1"
      description             = "All service accounts located in F1 used on the factory floor Operator PCs"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(user.userPrincipalName -startsWith \"sa-f1.\")"
    },
    {
      display_name            = "NV SA FV"
      description             = "All service accounts located in FV used on the factory validation Operator PCs"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(user.userPrincipalName -startsWith \"sa-fv.\")"
    },
  ]
}
