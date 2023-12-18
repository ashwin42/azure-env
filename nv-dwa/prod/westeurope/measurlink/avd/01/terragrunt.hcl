terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.10.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//wvd/"
}
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common-avd.hcl"))
}

inputs = {
  workspaces = [merge(local.common.inputs.workspaces[0],
    {
      friendly_name = "Measurlink Dwa"
      description   = "Measurlink Dwa"
    },
    )
  ]
  host_pools = [merge(local.common.inputs.host_pools[0],
    {
      friendly_name = "Measurlink Dwa"
      description   = "Measurlink Dwa"
    },
    )
  ]
  application_groups = [merge(local.common.inputs.application_groups[0],
    {
      friendly_name                = "Measurlink Dwa"
      default_desktop_display_name = "Measurlink Dwa"
      description                  = "Measurlink Dwa"
      # assign_groups = [
      #   "",
      # ]
    },
    )
  ]
}
