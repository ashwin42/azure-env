terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.5.5"
  #source = "../../../../../../tf-mod-azure/wvd/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  wvd_hp_name                  = "lims-${basename(get_terragrunt_dir())}-hp"
  wvd_ag_name                  = "lims-${basename(get_terragrunt_dir())}-ag"
  wvd_ws_name                  = "lims-${basename(get_terragrunt_dir())}-ws"
  wvd_ws_friendly_name         = "LIMS Labs"
  wvd_location                 = "westeurope"
  default_desktop_display_name = "Remote Desktop"
  custom_rdp_properties        = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;"

  assign_groups = [
    "NV TechOps Role",
    #    "Labware Users",
  ]
}

