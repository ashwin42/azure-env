terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.6.10"
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
    wvd_ws_friendly_name = "PNE Virtual Desktop TC3 - 03.01 to 03.10"
  }
)
