terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.10.3"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/wvd/"
}
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common-wvd.hcl"))
}

inputs = {
  workspaces = [merge(local.common.inputs.workspaces[0],
    {
      friendly_name = "R&D 2.0 - Hangke"
      description   = "Remote desktop for Hangke in R&D 2.0"
    },
    )
  ]
  host_pools = [merge(local.common.inputs.host_pools[0],
    {
      friendly_name = "R&D 2.0 - Hangke"
      description   = "Remote desktop for Hangke in R&D 2.0"
    },
    )
  ]
  application_groups = [merge(local.common.inputs.application_groups[0],
    {
      friendly_name                = "R&D 2.0 - Hangke"
      default_desktop_display_name = "R&D 2.0 - Hangke"
      description                  = "Remote desktop for Hangke in R&D 2.0"
      assign_groups = [
        "NV R&D2.0 Hangke Pre-Charger VM",
      ]
    },
    )
  ]
}
