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
  wvd_ws_friendly_name = "PNE Virtual Desktop TC11c - 11.21 to 11.25"
  wvd_hp_name          = "nv-pne-hp-tc11c"
  wvd_ag_name          = "nv-pne-hp-DAG-tc11c"
  wvd_ws_name          = "nv-pne-hp-ws-tc11c"
  wvd_location         = "westeurope"
  assign_groups = [
    "NV TechOps Role",
    "P&L Validation Labs PNE Virtual Desktop users",
    "AAD-PNE-VPN-AP",
  ]
}
