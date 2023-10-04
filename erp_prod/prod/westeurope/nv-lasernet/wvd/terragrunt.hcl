terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.8.6"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/wvd/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  name = include.root.inputs.project_name
  host_pools = [
    {
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
      workspace_name = local.name,
    }
  ]
}

inputs = {
  workspaces = [
    {
      name          = local.name
      friendly_name = "Lasernet Virtual Desktop"
    },
  ]

  host_pools = [
    merge(local.host_pools[0],
      {
        name                  = "${local.name}-hp"
        custom_rdp_properties = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;targetisaadjoined:i:1;enablerdsaadauth:i:1;"
        friendly_name         = "Lasernet Hostpool"
        description           = "Lasernet Hostpool"
      }
    ),
  ]

  application_groups = [
    merge(local.application_groups[0],
      {
        name                         = "${local.name}-ag"
        host_pool_name               = "${local.name}-hp"
        friendly_name                = "Lasernet Application Group"
        default_desktop_display_name = "Lasernet Virtual Desktop"
        description                  = "Application group for Lasernet Prod Virtual Desktop"
        assign_groups = [
          "NV TechOps Role",
          "NV Business Systems Common Member"
        ]
      }
    ),
  ]
}

