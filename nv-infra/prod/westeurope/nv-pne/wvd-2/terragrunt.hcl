terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.2.15"
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
  wvd_ws_friendly_name = "PNE Virtual Desktop TC7"
  wvd_hp_name          = "nv-pne-hp-2"
  wvd_ag_name          = "nv-pne-hp-DAG-2"
  wvd_ws_name          = "nv-pne-hp-ws-2"
  wvd_location         = "westeurope"
}
