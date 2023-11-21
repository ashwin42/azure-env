terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.7.5"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/wvd/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "global" {
  config_path = "../global"
}

inputs = {
  resource_group_name      = dependency.global.outputs.resource_group.name
  setup_prefix             = dependency.global.outputs.setup_prefix
  wvd_ws_friendly_name     = "GaBi LCA Virtual Desktop"
  maximum_sessions_allowed = 1
  assign_groups            = ["NV TechOps Role", "NV IT Service Support Member"]
  custom_rdp_properties    = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;"
}
