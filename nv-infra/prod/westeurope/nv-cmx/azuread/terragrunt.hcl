terraform {
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  groups = [
    {
      display_name = "CMX VPN Eligible"
      description  = "Members in this group can request access to CMX Access Package"
      members      = ["johan.nyaker@northvolt.com", "bojan.velichkov@northvolt.com"]
    },
    {
      display_name = "CMX VPN AP"
      description  = "Members in this group gets access to CMX cloud setup WVD and VPN"
      members      = []
    },
  ]
}

