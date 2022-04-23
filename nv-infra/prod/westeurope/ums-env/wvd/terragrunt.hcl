terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.3.0"
  #source = "../../../../../../tf-mod-azure/wvd/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  wvd_ws_friendly_name         = "Vaisala viewLinc Enterprise Server Virtual Desktop"
  wvd_location                 = "westeurope"
  default_desktop_display_name = "Remote Desktop"
  custom_rdp_properties        = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;"

  assign_groups = [
    "NV TechOps Role",
    "NV ViewLinc UMS User Access",
    "NV ViewLinc UMS Administrator Access",
  ]
}
