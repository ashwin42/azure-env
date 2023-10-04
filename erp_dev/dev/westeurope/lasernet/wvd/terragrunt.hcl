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
}

inputs = {
  workspaces = [
    {
      name         = "${local.name}-ws" 
      friendly_name = "Lasernet Dev Virtual Desktop"
    },
  ]

  host_pools = [
    {
      name                  = "${local.name}-dev-hp"
      custom_rdp_properties = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;targetisaadjoined:i:1;enablerdsaadauth:i:1;"
      friendly_name         = "Lasernet Dev Hostpool"
      description           = "Lasernet Dev Hostpool"
    }
  ]

  application_groups = [
    {
      name                         = "${local.name}-dev-ag"
      host_pool_name               = "${local.name}-dev-hp"
      workspace_name               = "${local.name}-ws"
      friendly_name                = "Lasernet Application Group"
      default_desktop_display_name = "Lasernet Dev Virtual Desktop"
      description                  = "Application group for Lasernet Dev Virtual Desktop"
      assign_groups = [
        "NV TechOps Role",
        "NV Business Systems Common Member"
      ]
    }
  ]
}

