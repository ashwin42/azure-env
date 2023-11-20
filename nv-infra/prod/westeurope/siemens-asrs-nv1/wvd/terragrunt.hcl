terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.9.4"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/wvd/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}


locals {
  name = "siemens-mgmt"
}

inputs = {
  workspaces = [
    {
      name          = local.name
      friendly_name = "Siemens"
    },
  ]
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
      name                  = "${local.name}-aad-mdm"
      custom_rdp_properties = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;targetisaadjoined:i:1;enablerdsaadauth:i:1;"
      friendly_name         = "Siemens Management WVD"
      description           = "Management VM for Siemens"
    }
  ]
  application_groups = [
    {
      workspace_name               = local.name,
      name                         = "${local.name}-aad-mdm"
      host_pool_name               = "${local.name}-aad-mdm"
      friendly_name                = "Siemens Management WVD"
      default_desktop_display_name = "Siemens Management WVD"
      description                  = "Management VM for Siemens"
      assign_groups = [
        "VPN Siemens ASRS AP",
      ]
    }
  ]
}

