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
      display_name            = "MDM F1.C1.SU"
      description             = "All Windows devices located in MDM F1.C1.SU"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.C1.SU\")"
    },
    {
      display_name            = "MDM F1.C1.CT"
      description             = "All Windows devices located in MDM F1.C1.CT"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.C1.CT\")"
    },
    {
      display_name            = "MDM F1.C1.CT.COT01"
      description             = "All Windows devices located in MDM F1.C1.CT.COT01"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.C1.CT.COT01\")"
    },
    {
      display_name            = "MDM F1.C1.CD.CLD03"
      description             = "All Windows devices located in MDM F1.C1.CD.CLD03"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.C1.CD.CLD03\")"
    },
    {
      display_name            = "MDM F1.C1.CD"
      description             = "All Windows devices located in MDM F1.C1.CD"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.C1.CD\")"
    },
    {
      display_name            = "MDM F1.C1.NS"
      description             = "All Windows devices located in MDM F1.C1.NS"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.C1.NS\")"
    },
    {
      display_name            = "MDM F1.C1"
      description             = "All Windows devices located in MDM F1.C1"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.C1\")"
    },
  ]
}
