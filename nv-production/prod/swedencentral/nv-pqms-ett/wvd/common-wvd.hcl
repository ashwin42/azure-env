/* commented out until we know if operator client on wvd is needed
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  name = "${basename(get_original_terragrunt_dir())}"
}
inputs = {
  workspaces = [
    {
      name                = "${local.name}-ws"
      resource_group_name = include.root.locals.all_vars.resource_group_name
      location            = "westeurope"
    },
  ]
  host_pools = [
    {
      name                  = "${local.name}-hp"
      resource_group_name   = include.root.locals.all_vars.resource_group_name
      location              = "westeurope"
      custom_rdp_properties = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;"
    },
  ]
  application_groups = [
    {
      name                = "${local.name}-ag"
      resource_group_name = include.root.locals.all_vars.resource_group_name
      location            = "westeurope"
      host_pool_name      = "${local.name}-hp"
      workspace_name      = "${local.name}-ws"
    },
  ]
}
*/