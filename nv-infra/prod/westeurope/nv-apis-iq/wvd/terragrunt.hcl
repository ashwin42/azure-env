terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//deprecated/wvd?ref=v0.7.61"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//deprecated/wvd/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  wvd_hp_name                = "apis-iq-wvd-hp"
  wvd_ws_name                = "apis-iq-wvd-ws"
  wvd_ag_name                = "apis-iq-wvd-ag"
  wvd_ws_friendly_name         = "APIS IQ Virtual Desktop"
  default_desktop_display_name = "APIS IQ"
  wvd_location                 = "westeurope"
  custom_rdp_properties        = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;"

  assign_groups = [
    "NV TechOps Role",
    "APIS IQ User Access",
  ]
}

