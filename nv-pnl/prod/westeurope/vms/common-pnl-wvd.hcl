include {
  path = find_in_parent_folders()
}



locals {
  name = basename(get_original_terragrunt_dir())
}

inputs = {
  #resource_group_name  = dependency.resource_group.outputs.resource_group.name
  #setup_prefix         = dependency.global.outputs.setup_prefix  
  wvd_hp_name  = "${local.name}-hp"
  wvd_ag_name  = "${local.name}-ag"
  wvd_ws_name  = "${local.name}-ws"
  wvd_location = "westeurope"
  assign_groups = [
    "NV TechOps Role",
    "P&L Validation Labs PNE Virtual Desktop users",
    "NV-PNE-VPN-AP",
  ]
}
