terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.7.34"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/wvd/"
}

include {
  path = find_in_parent_folders()
}


inputs = {
  workspaces = [
    {
      name          = "pne-tc3-wvd1-ws"
      friendly_name = "PNE - TC3 03.01 to 03.10"
    },
    {
      name          = "pne-tc3-wvd2-ws"
      friendly_name = "PNE - TC3 03.11 to 03.22"
    },
  ]

  host_pools = [
    {
      name = "pne-tc3-wvd1-hp"
    },
    {
      name = "pne-tc3-wvd2-hp"
    },
  ]

  application_groups = [
    {
      name = "pne-tc3-wvd1-ag"
      friendly_name = "03.01 - 03.10"
      default_desktop_display_name = "03.01 - 03.10"
      host_pool_name = "pne-tc3-wvd1-hp"
      workspace_name = "pne-tc3-wvd1-ws"
      assign_groups = [
        "NV TechOps Role",
        "P&L Validation Labs PNE Virtual Desktop users",
        "NV-PNE-VPN-AP",
      ]
    },
    {
      name = "pne-tc3-wvd2-ag"
      friendly_name = "03.11 - 03.22"
      default_desktop_display_name = "03.11 - 03.22"
      host_pool_name = "pne-tc3-wvd2-hp"
      workspace_name = "pne-tc3-wvd2-ws"
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

