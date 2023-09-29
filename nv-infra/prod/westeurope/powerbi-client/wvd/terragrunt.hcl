terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.2.30"
  #source = "../../../../../../tf-mod-azure/wvd/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  wvd_ws_friendly_name         = "PowerBI Desktop"
  wvd_location                 = "westeurope"
  default_desktop_display_name = "Remote Desktop"
  custom_rdp_properties        = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;"

  assign_groups = [
    "NV TechOps Role",
    "PowerBI Virtual Desktop Users",
  ]
  additional_applications = [
    {
      name                         = "Power-BI-Desktop"
      group_name                   = "Power-BI-Desktop"
      friendly_name                = "Power BI Desktop"
      group_friendly_name          = "Power BI Desktop Application Group"
      description                  = null
      path                         = "C:\\Program Files\\Microsoft Power BI Desktop\\bin\\PBIDesktop.exe"
      icon_path                    = "C:\\Program Files\\Microsoft Power BI Desktop\\bin\\PBIDesktop.exe"
      command_line_argument_policy = "DoNotAllow"
      icon_index                   = 0
      assign_groups = [
        "NV TechOps Role",
        "PowerBI Virtual Desktop Users",
      ]
    },
  ]
}

