terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.9.3"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/wvd-full/"
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
      friendly_name = "Dwa Papercut"
      description   = "Dwa Printing Management System"
    },
    )
  ]
  host_pools = [merge(local.common.inputs.host_pools[0],
    {
      friendly_name = "Dwa Papercut Host Pool"
      description   = "Dwa Papercut Host Pool"
    },
    )
  ]
  application_groups = [merge(local.common.inputs.application_groups[0],
    {
      friendly_name                = "Papercut VM"
      default_desktop_display_name = "Papercut VM"
      description                  = "Papercut VM"
      assign_groups = [
        "NV TechOps Role",
        "Printing Management System (Papercut) for Poland entity - Admin - Production",
      ]
    },
    )
  ]
}
