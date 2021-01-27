terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.2.0"
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
  wvd_ws_friendly_name = "GaBi LCA Virtual Desktop"
#  wvd_hp_name          = "nv-gabi-lca-hp"
#  wvd_ag_name          = "nv-gabi-lca-ag"
#  wvd_ws_name          = "nv-gabi-lca-ws"
}
