terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.3.0"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "global" {
  config_path = "../global"
}

inputs = {
  resource_group_name          = dependency.global.outputs.resource_group.name
  setup_prefix                 = dependency.global.outputs.setup_prefix
  wvd_ws_friendly_name         = "Cell Assembly WS Virtual Desktop"
  wvd_hp_name                  = "nv-ca-ws-hp"
  wvd_ag_name                  = "nv-ca-ws-ag"
  wvd_ws_name                  = "nv-ca-ws-ws"
  default_desktop_display_name = "SessionDesktop"
  custom_rdp_properties        = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;"
}
