terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//deprecated/wvd?ref=v0.7.44"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/wvd/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "global" {
  config_path = "../global"
}

inputs = {
  resource_group_name   = dependency.global.outputs.resource_group.name
  setup_prefix          = dependency.global.outputs.setup_prefix
  wvd_ws_friendly_name  = "CMX Virtual Desktop"
  wvd_location          = "westeurope"
  assign_groups         = ["NV TechOps Role", "CMX VPN Eligible", "CMX virtual desktop user access"]
  assign_users          = ["markku.liebl@northvolt.com", "uwe.laudahn.nve@northvolt.com", "henrik.miiro@northvolt.com"]
  custom_rdp_properties = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;"

  additional_applications = [
    {
      name                         = "CMX"
      group_name                   = "CMX"
      friendly_name                = "CMX"
      group_friendly_name          = "CMX Application Group"
      description                  = null
      path                         = "C:\\Program Files (x86)\\CMX\\BxbMUIPD.exe"
      command_line_argument_policy = "DoNotAllow"
      command_line_arguments       = ""
      show_in_portal               = true
      icon_path                    = "C:\\Windows\\Installer\\{1A01B918-3FEE-493C-B3ED-711B029877DC}\\icon.ico"
      icon_index                   = 0
      assign_groups                = ["NV TechOps Role", "CMX VPN Eligible", "CMX virtual desktop user access"]
      assign_users                 = ["markku.liebl@northvolt.com", "uwe.laudahn.nve@northvolt.com"]
    },
  ]
}
