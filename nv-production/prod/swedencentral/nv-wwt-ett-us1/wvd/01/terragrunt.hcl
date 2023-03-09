terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.7.12"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/wvd-full/"
}
include {
  path = find_in_parent_folders()
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common-wwt-wvd.hcl"))
}

inputs = {
  workspaces = [merge(local.common.inputs.workspaces[0],
    {
      friendly_name = "US1 Wastewater treatment"
      description   = "Remote desktop to operate US1 Wastewater treatment"
    },
    )
  ]
  host_pools = [merge(local.common.inputs.host_pools[0],
    {
      friendly_name = "US1 WWT Operator Pool"
      description   = "Remote desktop to operate US1 Wastewater treatment"
    },
    )
  ]
  application_groups = [merge(local.common.inputs.application_groups[0],
    {
      friendly_name                = "US1 WWT Operator VM"
      default_desktop_display_name = "US1 WWT Operator VM"
      description                  = "Remote desktop to operate US1 Wastewater treatment"
      assign_groups = [
        "NV TechOps Role",
        "US1 WWT Servers VPN AP",
      ]
    },
    )
  ]
}
