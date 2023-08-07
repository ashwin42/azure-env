terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.5.0"
  #source = "../../../../tf-mod-azure/wvd"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix          = "labx-ett"
  wvd_ws_friendly_name  = "LabX Ett Virtual Desktop"
  custom_rdp_properties = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;"
}
