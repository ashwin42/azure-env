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
      friendly_name = "PQMS Ett"
      description   = "Remote desktop to operate PQMS Ett"
    },
    )
  ]
  host_pools = [merge(local.common.inputs.host_pools[0],
    {
      friendly_name = "PQMS Ett"
      description   = "Remote desktop to operate PQMS Ett"
    },
    )
  ]
  application_groups = [merge(local.common.inputs.application_groups[0],
    {
      friendly_name                = "PQMS Ett"
      default_desktop_display_name = "PQMS Ett Operator VM"
      description                  = "Remote desktop to operate PQMS Ett"
      assign_groups = [
        "NV TechOps Role",
        #"PQMS Admin Access",
        #"PQMS User Access",
      ]
    },
    )
  ]
}
