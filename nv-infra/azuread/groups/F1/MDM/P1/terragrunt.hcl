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
      display_name            = "MDM F1.P1"
      description             = "All Windows devices located in MDM F1.P1"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.P1\")"
    },
    {
      display_name            = "MDM F1.P1.PS"
      description             = "All Windows devices located in MDM F1.P1.PS"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.P1.PS\")"
    },
    {
      display_name            = "MDM F1.P1.PY1"
      description             = "All Windows devices located in MDM F1.P1.PY1"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.P1.PY1\")"
    },
  ]
}
