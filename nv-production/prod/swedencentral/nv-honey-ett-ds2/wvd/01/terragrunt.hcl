terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.7.9"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/wvd/"
}
include {
  path = find_in_parent_folders()
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common-wvd.hcl"))
}

inputs = {
  workspaces = [merge(local.common.inputs.workspaces[0],
    {
      friendly_name = "DS2 Honeywell beta gauges"
      description   = "Remote desktop to operate DS2 Honeywell beta gauges"
    },
    )
  ]
  host_pools = [merge(local.common.inputs.host_pools[0],
    {
      friendly_name = "DS2 Honeywell Operator Pool"
      description   = "Remote desktop to operate US1 Wastewater treatment"
    },
    )
  ]
  application_groups = [merge(local.common.inputs.application_groups[0],
    {
      friendly_name                = "DS2 Honeywell Operator VM"
      default_desktop_display_name = "DS2 Honeywell Operator VM"
      description                  = "Remote desktop to operate DS2 Honeywell beta gauges"
      assign_groups = [
        "NV TechOps Role",
        "Ett-Supplier-Honeywell-VPN",
        "NV Automation Member",
        "NV F1.C21.CT.COT01",
        "NV F1.C21.CT.COT02",
        "NV F1.C21.CT.COT03",
        "NV F1.A21.CT.COT01",
        "NV F1.A21.CT.COT02",
        "NV F1.A21.CT.COT03",
      ]
    },
    )
  ]
}
