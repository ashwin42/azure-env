terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.8.6"
  # source = "../../../../../../tf-mod-azure/wvd/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  workspaces = [
    {
      name          = "ums-env-wvd-ws"
      friendly_name = "Vaisala viewLinc Enterprise Server Virtual Desktop"
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
      name                  = "ums-env-wvd-hp"
      custom_rdp_properties = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;"
      friendly_name         = "Default Desktop Host Pool"
      description           = "Desktop Host Pool created with Terraform"
    }
  ]
  application_groups = [
    {
      workspace_name               = "ums-env-wvd-ws"
      name                         = "ums-env-wvd-ag"
      host_pool_name               = "ums-env-wvd-hp"
      friendly_name                = "Default Desktop"
      default_desktop_display_name = "Default Desktop"
      description                  = "Desktop Application Group created with Terraform"
      assign_groups = [
        "NV TechOps Role",
        "NV ViewLinc UMS User Access",
        "NV ViewLinc UMS Administrator Access",
      ]
    }
  ]
}

