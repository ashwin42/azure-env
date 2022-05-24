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
  wvd_ws_friendly_name = "PNE Virtual Desktop TC8"
  wvd_hp_name          = "nv-pne-hp-tc8"
  wvd_ag_name          = "nv-pne-hp-DAG-tc8"
  wvd_ws_name          = "nv-pne-hp-ws-tc8"
  wvd_location         = "westeurope"
  assign_groups = [
    "NV TechOps Role",
    "P&L Validation Labs PNE Virtual Desktop users",
    "AAD-PNE-VPN-AP",
  ]
}
