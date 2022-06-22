terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//groups?ref=v1.1.0"
  #source = "../../../../../../tf-mod-azuread/groups/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  groups = [
    {
      display_name = "Remote Access Server Umbrella Group Ett"
      description  = "Groups assigned to this group will be synced to remote access server ett database"
      security_enabled = true
      member_groups = [
        "NV F1.A1.CT.COT01",
        "NV F1.C1.CT.COT01",
        "NV F1.A1.SU",
        "NV F1.C1.SU",
        "NV F1.C1.CD.CLD03",
        "NV F1.A1.CD.CLD03",
        "NV F1.A1.CT.COT02",
        "NV F1.C1.CT.COT02",
        "NV F1.A1.CT.COT03",
        "NV F1.C1.CT.COT03",
        "NV TechOps Role",
        "Ett Supplier VPN Wuxi Titans",
        "VPN-F1-F1-PF2-AP",
      ]
    },
    {
      display_name = "Remote Access Server Ett VPN AP"
      description  = "Provides VPN access to Ett Remote Server"
      security_enabled = true
      member_groups = []
    },
  ]
}

