include {
  path = find_in_parent_folders()
}



locals {
  name = basename(get_original_terragrunt_dir())
}

inputs = {
  wvd_hp_name           = "${local.name}-hp"
  wvd_ag_name           = "${local.name}-ag"
  wvd_ws_name           = "${local.name}-ws"
  wvd_location          = "westeurope"
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

