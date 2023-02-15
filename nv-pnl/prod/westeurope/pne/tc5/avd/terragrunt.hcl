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
      name          = "pne-tc5-wvd1-ws"
      friendly_name = "PNE - TC5 05.01 to 05.10"
    },
    {
      name          = "pne-tc5-wvd2-ws"
      friendly_name = "PNE - TC5 05.11 to 05.20"
    },
    {
      name          = "pne-tc5-wvd3-ws"
      friendly_name = "PNE - TC5 05.21 to 05.29"
    },
  ]

  host_pools = [
    {
      name = "pne-tc5-wvd1-hp"
    },
    {
      name = "pne-tc5-wvd2-hp"
    },
    {
      name = "pne-tc5-wvd3-hp"
    },
  ]

  application_groups = [
    {
      name = "pne-tc5-wvd1-ag"
      friendly_name = "05.01 - 05.10"
      host_pool_name = "pne-tc5-wvd1-hp"
      workspace_name = "pne-tc5-wvd1-ws"
      assign_groups = [
        "NV TechOps Role",
        "P&L Validation Labs PNE Virtual Desktop users",
        "NV-PNE-VPN-AP",
      ]
    },
    {
      name = "pne-tc5-wvd2-ag"
      friendly_name = "05.11 - 05.20"
      host_pool_name = "pne-tc5-wvd2-hp"
      workspace_name = "pne-tc5-wvd2-ws"
      assign_groups = [
        "NV TechOps Role",
        "P&L Validation Labs PNE Virtual Desktop users",
        "NV-PNE-VPN-AP",
      ]
    },
    {
      name = "pne-tc5-wvd3-ag"
      friendly_name = "05.21 - 05.29"
      host_pool_name = "pne-tc5-wvd3-hp"
      workspace_name = "pne-tc5-wvd3-ws"
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

