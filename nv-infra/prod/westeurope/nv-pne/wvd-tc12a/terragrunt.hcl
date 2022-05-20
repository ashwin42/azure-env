terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.2.30"
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
  wvd_ws_friendly_name = "PNE Virtual Desktop TC12a - Keysight"
  wvd_hp_name          = "nv-pne-hp-tc12a"
  wvd_ag_name          = "nv-pne-hp-DAG-tc12a"
  wvd_ws_name          = "nv-pne-hp-ws-tc12a"
  wvd_location         = "westeurope"
  assign_groups = [
    "NV TechOps Role",
    "P&L Validation Labs Keysight Virtual Desktop users",
  ]
}
