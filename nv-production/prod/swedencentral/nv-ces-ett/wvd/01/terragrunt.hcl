terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.7.39"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/wvd/"
}
include {
  path = find_in_parent_folders()
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common-wvd.hcl"))
  name   = basename(dirname(dirname(get_terragrunt_dir())))
}

inputs = {
  workspaces = [merge(local.common.inputs.workspaces[0],
    )
  ]
  host_pools = [
    merge(local.common.inputs.host_pools[0],
      {
        name          = "${local.name}-01-hp"
        friendly_name = "Condmaster Ruby Ett"
        description   = "Remote desktop to Condmaster Ruby"
      }
    ),
  ]
  application_groups = [
    merge(local.common.inputs.application_groups[0],
      {
        name                         = "${local.name}-01-ag"
        host_pool_name               = "${local.name}-01-hp"
        friendly_name                = "Condmaster Ruby VM Ett"
        default_desktop_display_name = "Condmaster Ruby VM Ett"
        description                  = "Remote desktop to Condmaster Ruby in Ett"
        assign_groups = [
          "NV TechOps Role",
          "VPN Condmaster Servers Access AP",
        ]
      }
    ),
  ]
}
