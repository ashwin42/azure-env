terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.2.30"
  #source = "../../../../../../tf-mod-azure/wvd/"
}

include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

inputs = {
  resource_group_name  = dependency.global.outputs.resource_group.name
  setup_prefix         = dependency.global.outputs.setup_prefix
  wvd_ws_friendly_name = "CMX Virtual Desktop"
  wvd_location         = "westeurope"
  assign_groups        = ["TechOps", "CMX VPN Eligible"]
  assign_users         = ["markku.liebl@northvolt.com", "uwe.laudahn.nve@northvolt.com", "c.magnus.soderholtz@northvolt.com", "henrik.miiro@northvolt.com"]

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
      assign_groups                = ["TechOps", "CMX VPN Eligible"]
      assign_users                 = ["markku.liebl@northvolt.com", "uwe.laudahn.nve@northvolt.com"]
    },
    {
      name                         = "CMX-DB-Mgr"
      group_name                   = "CMX-DB-Mgr"
      friendly_name                = "CMX Database Manager"
      group_friendly_name          = "nv-cmx-cmx-ag"
      description                  = null
      path                         = "C:\\Program Files (x86)\\CMX\\BxbDatabaseSetup.exe"
      command_line_argument_policy = "DoNotAllow"
      command_line_arguments       = ""
      show_in_portal               = true
      icon_path                    = "C:\\Program Files (x86)\\CMX\\Db_manager_32x32_16M_16c_v3.ico"
      icon_index                   = 0
      assign_groups                = ["TechOps"]
      assign_users                 = []
    },
  ]
}
