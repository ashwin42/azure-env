terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.9.3"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/wvd/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  name = basename(get_original_terragrunt_dir())
}

inputs = {
  resource_group_name = "nv-pnl-vms-rg"
  workspaces = [
    {
      name          = "${local.name}-ws"
      friendly_name = "PNE - TC2"
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
      workspace_name               = "${local.name}-ws"
      host_pool_name               = "${local.name}-hp"
      friendly_name                = "02.01 - 02.10"
      default_desktop_display_name = "02.01 - 02.10"
      assign_groups = [
        "P&L Validation Labs PNE Virtual Desktop users",
        "NV-PNE-VPN-AP",
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


