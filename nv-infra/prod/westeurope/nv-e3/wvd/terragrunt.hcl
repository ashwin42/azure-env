terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.5.0"
  #source = "../../../../../../tf-mod-azure/wvd/"
}

include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

inputs = {
  resource_group_name   = dependency.global.outputs.resource_group.name
  setup_prefix          = dependency.global.outputs.setup_prefix
  wvd_ws_friendly_name  = "E3 Virtual Desktop"
  wvd_hp_type           = "Pooled"
  custom_rdp_properties = "drivestoredirect:s:*;redirectprinters:i:1;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;"
}
