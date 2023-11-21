terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.9.4"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//wvd/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}


inputs = {
  resource_group_name = "nv-pne-rg"
  workspaces = [
    {
      name          = "nv-pne-hp-ws-tc10a"
      friendly_name = "PNE TC10"
    },
  ]

  host_pools = [
    {
      name = "nv-pne-hp-tc10a"
    },
    {
      name = "nv-pne-hp-tc10b"
    },
  ]

  application_groups = [
    {
      name                         = "nv-pne-hp-DAG-tc10a"
      friendly_name                = "10.01 - 10.10"
      default_desktop_display_name = "10.01 - 10.10"
      host_pool_name               = "nv-pne-hp-tc10a"
      workspace_name               = "nv-pne-hp-ws-tc10a"
      assign_groups = [
        "P&L Validation Labs PNE Virtual Desktop users",
        "NV-PNE-VPN-AP",
      ]
    },
    {
      name                         = "nv-pne-hp-DAG-tc10b"
      friendly_name                = "10.11 - 10.19"
      default_desktop_display_name = "10.11 - 10.19"
      host_pool_name               = "nv-pne-hp-tc10b"
      workspace_name               = "nv-pne-hp-ws-tc10a"
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

