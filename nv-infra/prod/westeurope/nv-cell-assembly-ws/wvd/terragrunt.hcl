terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.2.12"
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
  wvd_ws_friendly_name = "Cell Assembly WS Virtual Desktop"
  wvd_hp_name          = "nv-ca-ws-hp"
  wvd_ag_name          = "nv-ca-ws-ag"
  wvd_ws_name          = "nv-ca-ws-ws"
}
