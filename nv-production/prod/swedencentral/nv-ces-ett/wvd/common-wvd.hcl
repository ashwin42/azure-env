# Include all settings from some parent .hcl files
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  workspaces = [
    {
      name                = "${basename(dirname(get_terragrunt_dir()))}-ws"
      friendly_name       = "Condmaster Ett"
      resource_group_name = include.root.locals.all_vars.resource_group_name
      location            = "westeurope"
    },
  ]
  host_pools = [
    {
      resource_group_name   = include.root.locals.all_vars.resource_group_name
      location              = "westeurope"
      custom_rdp_properties = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1; redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;targetisaadjoined:i:1;enablerdsaadauth:i:1;"
      scheduled_agent_updates = {
        enabled  = true
        timezone = "W. Europe Standard Time"
        schedule = [
          {
            day_of_week = "Sunday"
            hour_of_day = 23
          },
        ]
      },
    },
  ]
  application_groups = [
    {
      resource_group_name = include.root.locals.all_vars.resource_group_name
      location            = "westeurope"
      workspace_name      = "${basename(dirname(get_terragrunt_dir()))}-ws"
    },
  ]
}
