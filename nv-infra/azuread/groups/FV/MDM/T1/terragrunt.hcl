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
      display_name            = "MDM FV.T1.KEA"
      description             = "All Windows devices located in MDM FV.T1.KEA"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:FV.T1.KEA\")"
    },
    {
      display_name            = "MDM FV.T1"
      description             = "All Windows devices located in MDM FV.T1"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:FV.T1\")"
    },
    {
      display_name            = "MDM FV"
      description             = "All Windows devices located in MDM FV"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:FV\")"
    },
  ]
}
