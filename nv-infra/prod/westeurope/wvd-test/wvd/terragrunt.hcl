terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.7.34"
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
      friendly_name = "WVD Test AD"
    },
  ]
  host_pools = [
    merge(local.host_pools[0],
      {
        name                  = "${local.name}-aadds"
        custom_rdp_properties = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;"
        friendly_name         = "WVD Test AD - AADDS"
        description           = "AADDS joined VMs"
      }
    ),
    merge(local.host_pools[0],
      {
        name                  = "${local.name}-aad"
        custom_rdp_properties = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;targetisaadjoined:i:1;enablerdsaadauth:i:1;"
        friendly_name         = "WVD Test AD - AAD"
        description           = "AAD joined VMs"
      }
    ),
    merge(local.host_pools[0],
      {
        name                  = "${local.name}-aad-mdm"
        custom_rdp_properties = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;targetisaadjoined:i:1;enablerdsaadauth:i:1;"
        friendly_name         = "WVD Test AD - AAD MDM"
        description           = "AADDS joined, MDM managed VMs"
      }
    ),
  ]
  application_groups = [
    merge(local.application_groups[0],
      {
        name                         = "${local.name}-aadds"
        host_pool_name               = "${local.name}-aadds"
        friendly_name                = "AADDS Desktop"
        default_desktop_display_name = "AADDS joined VM"
        description                  = "AADDS joined VM"
        assign_groups = [
          "NV TechOps Role",
          "NV IT Core Role",
        ]
      }
    ),
    merge(local.application_groups[0],
      {
        name                         = "${local.name}-aad"
        host_pool_name               = "${local.name}-aad"
        friendly_name                = "AAD Desktop"
        default_desktop_display_name = "AAD joined VM"
        description                  = "AAD joined VM"
        assign_groups = [
          "NV TechOps Role",
          "NV IT Core Role",
        ]
      }
    ),
    merge(local.application_groups[0],
      {
        name                         = "${local.name}-aad-mdm"
        host_pool_name               = "${local.name}-aad-mdm"
        friendly_name                = "AAD MDM Desktop"
        default_desktop_display_name = "AAD joined MDM managed VM"
        description                  = "AAD joined MDM managed VM"
        assign_groups = [
          "NV TechOps Role",
          "NV IT Core Role",
        ]
      }
    ),
  ]
}

