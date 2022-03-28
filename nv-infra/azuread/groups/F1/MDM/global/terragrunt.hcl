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
      display_name            = "MDM F1"
      description             = "All Windows devices located in F1"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1\")"
    },
    {
      display_name            = "MDM F1 Operator iPads"
      description             = "All iOS devices located in MDM F1 Operator iPads"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.enrollmentProfileName -eq \"F1 Operator iPads\")"
    },
    {
      display_name            = "MDM F1 Comissioning iPads"
      description             = "All iOS devices located in MDM F1 Comissioning iPads"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.enrollmentProfileName -eq \"F1 Commissioning iPads\")"
    },
    {
      display_name            = "MDM F1 Kiosk devices"
      description             = "All Windows devices located in MDM F1 Kiosk devices"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any (_ -match \"^\\[OrderID\\]:.*factorykiosk*$\"))"
    },
  ]
}
