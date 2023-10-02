terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.7.34"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/wvd/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}


inputs = {
  resource_group_name = "nv-pne-rg"
  workspaces = [
    {
      name          = "nv-pne-hp-ws-tc11a"
      friendly_name = "PNE TC11"
    },
  ]

  host_pools = [
    {
      name = "nv-pne-hp-tc11a"
    },
    {
      name = "nv-pne-hp-tc11b"
    },
    {
      name = "nv-pne-hp-tc11c"
    },
  ]

  application_groups = [
    {
      name                         = "nv-pne-hp-DAG-tc11a"
      friendly_name                = "11.01 - 11.10"
      default_desktop_display_name = "11.01 - 11.10"
      host_pool_name               = "nv-pne-hp-tc11a"
      workspace_name               = "nv-pne-hp-ws-tc11a"
      assign_groups = [
        "NV TechOps Role",
        "P&L Validation Labs PNE Virtual Desktop users",
        "NV-PNE-VPN-AP",
      ]
    },
    {
      name                         = "nv-pne-hp-DAG-tc11b"
      friendly_name                = "11.11 - 11.20"
      default_desktop_display_name = "11.11 - 11.20"
      host_pool_name               = "nv-pne-hp-tc11b"
      workspace_name               = "nv-pne-hp-ws-tc11a"
      assign_groups = [
        "NV TechOps Role",
        "P&L Validation Labs PNE Virtual Desktop users",
      ]
    },
    {
      name                         = "nv-pne-hp-DAG-tc11c"
      friendly_name                = "11.21 - 11.25"
      default_desktop_display_name = "11.21 - 11.25"
      host_pool_name               = "nv-pne-hp-tc11c"
      workspace_name               = "nv-pne-hp-ws-tc11a"
      assign_groups = [
        "NV TechOps Role",
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

