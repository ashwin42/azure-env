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
      display_name            = "MDM F1.U1"
      description             = "All Windows devices located in MDM F1.U1"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.U1\")"
    },
    {
      display_name            = "MDM F1.U1.NR"
      description             = "All Windows devices located in MDM F1.U1.NR"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.U1.NR\")"
    },
  ]
}
