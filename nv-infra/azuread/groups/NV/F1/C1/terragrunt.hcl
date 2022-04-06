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
      display_name            = "NV F1.C1.SU"
      description             = "All service accounts located in F1.C1.SU used on the factory floor Operator PCs"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(user.userPrincipalName -startsWith \"sa-f1.c1.su\")"
    },
    {
      display_name            = "NV F1.C1.CT.COT01"
      description             = "All service accounts located in F1.C1.CT.COT01 used on the factory floor Operator PCs"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(user.userPrincipalName -startsWith \"sa-f1.c1.ct.cot01\")"
    },
    {
      display_name            = "NV F1.C1.CD.CLD03"
      description             = "All service accounts located in F1.C1.CD.CLD03 used on the factory floor Operator PCs"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(user.userPrincipalName -startsWith \"sa-f1.c1.cd.cld03\")"
    },
    {
      display_name            = "NV F1.C1.CT.COT02"
      description             = "All service accounts located in F1.C1.CT.COT02 used on the factory floor Operator PCs"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(user.userPrincipalName -startsWith \"sa-f1.c1.ct.cot02\")"
    },
    {
      display_name            = "NV F1.C1.CT.COT03"
      description             = "All service accounts located in F1.C1.CT.COT03 used on the factory floor Operator PCs"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(user.userPrincipalName -startsWith \"sa-f1.c1.ct.cot03\")"
    },
  ]
}
