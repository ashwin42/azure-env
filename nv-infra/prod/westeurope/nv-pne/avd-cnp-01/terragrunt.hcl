terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.7.51"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/wvd/"
}

include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

locals {
  name = "nv-pne-cnp-01"
}

inputs = {
  resource_group_name = dependency.global.outputs.resource_group.name
  workspaces = [
    {
      name          = "${local.name}-ws"
      friendly_name = "PNE - Coin & Pouch"
    },
  ]

  host_pools = [
    {
      name = "${local.name}-hp"
    },
  ]

  application_groups = [
    {
      name                         = "${local.name}-ag"
      friendly_name                = "Coin & Pouch"
      default_desktop_display_name = "Coin & Pouch"
      host_pool_name               = "${local.name}-hp"
      workspace_name               = "${local.name}-ws"
      assign_groups = [
        "NV TechOps Role",
      ]
    },
  ]

  enable_wvd_hp_logs = true
  log = [
    {
      category = "Connection"
    },
  ]
}

