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
  wvd_ws_friendly_name = "PNE Virtual Desktop TC6"
  wvd_hp_name          = "nv-pne-hp"
  wvd_ag_name          = "nv-pne-hp-DAG"

  enable_wvd_hp_logs = true
  log = [
    {
      category = "Connection"
    },
  ]

}
