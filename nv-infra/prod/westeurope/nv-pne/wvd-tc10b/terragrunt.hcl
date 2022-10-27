terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.7.8"
  #source = "../../../../../../tf-mod-azure/wvd/"
}

include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

inputs = {
  resource_group_name  = dependency.global.outputs.resource_group.name
  setup_prefix         = dependency.global.outputs.setup_prefix
  wvd_ws_friendly_name = "PNE Virtual Desktop TC10b - 10.11 to 10.19"
  wvd_hp_name          = "nv-pne-hp-tc10b"
  wvd_ag_name          = "nv-pne-hp-DAG-tc10b"
  wvd_ws_name          = "nv-pne-hp-ws-tc10b"
  wvd_location         = "westeurope"

  enable_wvd_hp_logs = true
  log = [
    {
      category = "Connection"
    },
  ]

  assign_groups = [
    "NV TechOps Role",
    "P&L Validation Labs PNE Virtual Desktop users",
    "NV-PNE-VPN-AP",
  ]
}
