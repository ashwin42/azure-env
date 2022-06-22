terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//groups?ref=v1.2.0"
  #source = "../../../../../tf-mod-azuread/groups/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  groups = [
    {
      display_name            = "NV F1.U1.NR"
      description             = "All service accounts located in F1.U1.NR used on the factory floor Operator PCs"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(user.userPrincipalName -startsWith \"sa-f1.u1.nr\")"
    },
    {
      display_name            = "NV F1.U1"
      description             = "All service accounts located in F1.U1 used on the factory floor Operator PCs"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(user.userPrincipalName -startsWith \"sa-f1.u1\")"
    },
  ]
}
