terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.7.8"
  #source = "../../../../../../../tf-mod-azure/wvd/"
}

include {
  path = find_in_parent_folders()
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common-pnl-wvd.hcl"))
}

inputs = merge(
  local.common.inputs,
  {
    wvd_ws_friendly_name         = "PNE - TC4"
    default_desktop_display_name = "04.02 - 04.08"
  }
)
