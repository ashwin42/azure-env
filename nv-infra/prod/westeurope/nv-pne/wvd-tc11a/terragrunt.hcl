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
  wvd_ws_friendly_name = "PNE Virtual Desktop TC11a - 11.01 to 11.10"
  wvd_hp_name          = "nv-pne-hp-tc11a"
  wvd_ag_name          = "nv-pne-hp-DAG-tc11a"
  wvd_ws_name          = "nv-pne-hp-ws-tc11a"
  wvd_location         = "westeurope"

  custom_rdp_properties = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;"
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
