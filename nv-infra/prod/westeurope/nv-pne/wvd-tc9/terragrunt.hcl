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
  resource_group_name          = dependency.global.outputs.resource_group.name
  setup_prefix                 = dependency.global.outputs.setup_prefix
  wvd_ws_friendly_name         = "PNE - TC9"
  default_desktop_display_name = "09.01 - 09.09"
  wvd_hp_name                  = "nv-pne-hp-tc9"
  wvd_ag_name                  = "nv-pne-hp-DAG-tc9"
  wvd_ws_name                  = "nv-pne-hp-ws-tc9"
  wvd_location                 = "westeurope"

  custom_rdp_properties = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;"
  enable_wvd_hp_logs    = true
  log = [
    {
      category = "Connection"
    },
  ]

}
