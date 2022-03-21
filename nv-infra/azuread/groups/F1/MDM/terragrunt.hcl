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
      display_name            = "MDM F1.P1"
      description             = "All Windows devices located in MDM F1.P1"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.P1\")"
    },
    {
      display_name            = "MDM F1.A1.SU"
      description             = "All Windows devices located in MDM F1.A1.SU"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.A1.SU\")"
    },
    {
      display_name            = "MDM FV.T1.KEA"
      description             = "All Windows devices located in MDM FV.T1.KEA"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:FV.T1.KEA\")"
    },
    {
      display_name            = "MDM F1.A1.CD.CLD03"
      description             = "All Windows devices located in MDM F1.A1.CD.CLD03"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.A1.CD.CLD03\")"
    },
    {
      display_name            = "MDM F1.A1.CD"
      description             = "All Windows devices located in MDM F1.A1.CD"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.A1.CD\")"
    },
    {
      display_name            = "MDM F1 Operator iPads"
      description             = "All iOS devices located in MDM F1 Operator iPads"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.enrollmentProfileName -eq \"F1 Operator iPads\")"
    },
    {
      display_name            = "MDM F1.A1.CT.COT01"
      description             = "All Windows devices located in MDM F1.A1.CT.COT01"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.A1.CT.COT01\")"
    },
    {
      display_name            = "MDM F1.A1.NS"
      description             = "All Windows devices located in MDM F1.A1.NS"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.A1.NS\")"
    },
    {
      display_name            = "MDM F1.C1.SU"
      description             = "All Windows devices located in MDM F1.C1.SU"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.C1.SU\")"
    },
    {
      display_name            = "MDM F1.P1.PS"
      description             = "All Windows devices located in MDM F1.P1.PS"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.P1.PS\")"
    },
    {
      display_name            = "MDM F1 Comissioning iPads"
      description             = "All iOS devices located in MDM F1 Comissioning iPads"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.enrollmentProfileName -eq \"F1 Commissioning iPads\")"
    },
    {
      display_name            = "MDM F1.A1.CT"
      description             = "All Windows devices located in MDM F1.A1.CT"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.A1.CT\")"
    },
    {
      display_name            = "MDM F1.C1.CT"
      description             = "All Windows devices located in MDM F1.C1.CT"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.C1.CT\")"
    },
    {
      display_name            = "MDM F1.P1.PY1"
      description             = "All Windows devices located in MDM F1.P1.PY1"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.P1.PY1\")"
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
      display_name            = "MDM F1 Kiosk devices"
      description             = "All Windows devices located in MDM F1 Kiosk devices"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any (_ -match \"^\\[OrderID\\]:.*factorykiosk*$\"))"
    },
    {
      display_name            = "MDM F1.C1.NS"
      description             = "All Windows devices located in MDM F1.C1.NS"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.C1.NS\")"
    },
    {
      display_name            = "MDM FV.T1"
      description             = "All Windows devices located in MDM FV.T1"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:FV.T1\")"
    },
    {
      display_name            = "MDM F1.C1"
      description             = "All Windows devices located in MDM F1.C1"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.C1\")"
    },
    {
      display_name            = "MDM F1.A1"
      description             = "All Windows devices located in MDM F1.A1"
      security_enabled        = true
      types                   = ["DynamicMembership"]
      dynamic_membership_rule = "(device.devicePhysicalIds -any _ -startsWith \"[OrderID]:F1.A1\")"
    },
  ]
}
