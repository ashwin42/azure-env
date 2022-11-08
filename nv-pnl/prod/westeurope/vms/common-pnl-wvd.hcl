include {
  path = find_in_parent_folders()
}



locals {
  name = basename(get_original_terragrunt_dir())
}

inputs = {
  wvd_hp_name  = "${local.name}-hp"
  wvd_ag_name  = "${local.name}-ag"
  wvd_ws_name  = "${local.name}-ws"
  wvd_location = "westeurope"

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

