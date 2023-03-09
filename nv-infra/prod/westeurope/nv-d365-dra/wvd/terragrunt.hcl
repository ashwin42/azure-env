terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//deprecated/wvd?ref=v0.7.44"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/wvd/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix                 = "nv-d365-dra"
  wvd_ws_friendly_name         = "D365 Document Routing Server"
  wvd_location                 = "westeurope"
  default_desktop_display_name = "Remote Desktop"
  custom_rdp_properties        = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;targetisaadjoined:i:1;"

  assign_groups = [
    "NV TechOps Role",
    "NV IT Core Role",
    "D365 DRA User Access",
  ]
}

