terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.9.4"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/wvd"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common-wwt-wvd.hcl"))
}

inputs = {
  workspaces = [merge(local.common.inputs.workspaces[0],
    {
      friendly_name = "US1 Wastewater treatment TIA"
      description   = "RDP to US1 Wastewater treatment TIA"
    },
    )
  ]
  host_pools = [merge(local.common.inputs.host_pools[0],
    {
      friendly_name = "US1 WWT TIA"
      description   = "RDP to US1 Wastewater treatment TIA"
    },
    )
  ]
  application_groups = [merge(local.common.inputs.application_groups[0],
    {
      friendly_name                = "US1 WWT TIA VM"
      default_desktop_display_name = "US1 WWT TIA VM"
      description                  = "RDP to US1 Wastewater treatment TIA VM"
      assign_groups = [
        "US1 WWT Servers VPN AP",
        "NV Automation Member",
      ]
    },
    )
  ]
}
