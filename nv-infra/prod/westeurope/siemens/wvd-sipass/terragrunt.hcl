terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//deprecated/wvd?ref=v0.7.59"
  #source = "../../../../../../tf-mod-azure/wvd/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  resource_group_name          = "nv_siemens"
  setup_prefix                 = "sipass"
  wvd_ws_friendly_name         = "Sipass Windows Virtual Desktop"
  wvd_location                 = "westeurope"
  default_desktop_display_name = "Remote Desktop"
  custom_rdp_properties        = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;"

  assign_groups = [
    "NV TechOps Role",
    "Physical Security Administrators",
    "Physical Security Server Administrators",
  ]

  additional_applications = [
    {
      name                         = "SiPassBrowser"
      group_name                   = "SiPassBrowser"
      friendly_name                = "SiPass integrated Web Client"
      group_friendly_name          = "SiPass integrated Web Client Application Group"
      description                  = null
      path                         = "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe"
      command_line_argument_policy = "Require"
      command_line_arguments       = "https://ps-ac-sipass.aadds.northvolt.com:5443/SiPass/#/"
      show_in_portal               = true
      icon_path                    = "C:\\Program Files (x86)\\SiPass integrated\\SiPassOpClient.exe"
      icon_index                   = 0
      assign_groups                = ["NV TechOps Role", "Physical Security Administrators", "Physical Security Access Users"]
    },
    {
      name                         = "SiPassCC"
      group_name                   = "SiPassCC"
      friendly_name                = "SiPass Configuration Cient"
      group_friendly_name          = "SiPass Configuration Client Application Group"
      description                  = null
      path                         = "C:\\Program Files (x86)\\SiPass integrated\\SiPassConfigurationClient.exe"
      command_line_argument_policy = "DoNotAllow"
      command_line_arguments       = ""
      show_in_portal               = true
      icon_path                    = "C:\\Program Files (x86)\\SiPass integrated\\SiPassConfigurationClient.exe"
      icon_index                   = 0
      assign_groups                = ["NV TechOps Role", "Physical Security Administrators"]
    },
    {
      name                         = "SiPassOC"
      group_name                   = "SiPassOC"
      friendly_name                = "SiPass Operation Cient"
      group_friendly_name          = "SiPass Operation Client Application Group"
      description                  = null
      path                         = "C:\\Program Files (x86)\\SiPass integrated\\SiPassOpClient.exe"
      command_line_argument_policy = "DoNotAllow"
      command_line_arguments       = ""
      show_in_portal               = true
      icon_path                    = "C:\\Program Files (x86)\\SiPass integrated\\SiPassOpClient.exe"
      icon_index                   = 0
      assign_groups                = ["NV TechOps Role", "Physical Security Administrators", "Physical Security Evac Leader"]
    },
    {
      name                         = "SiPassIE"
      group_name                   = "SiPassImportExport"
      friendly_name                = "SiPass Import Export Tool"
      group_friendly_name          = "SiPass Import/Export Application Group"
      description                  = null
      path                         = "C:\\Program Files (x86)\\SiPass integrated\\CardholderImportExport.exe"
      command_line_argument_policy = "DoNotAllow"
      command_line_arguments       = ""
      show_in_portal               = true
      icon_path                    = "C:\\Program Files (x86)\\SiPass integrated\\CardholderImportExport.exe"
      icon_index                   = 0
      assign_groups                = ["NV TechOps Role", "Physical Security Administrators"]
    },
    {
      name                         = "VMSClient"
      group_name                   = "VMSClient"
      friendly_name                = "VMS Client"
      group_friendly_name          = "VMS Client Application Group"
      description                  = null
      path                         = "C:\\Program Files\\Siemens\\Siveillance VMS Video Client\\Client.exe"
      command_line_argument_policy = "DoNotAllow"
      command_line_arguments       = ""
      show_in_portal               = true
      icon_path                    = "C:\\Windows\\Installer\\{09ED1BB2-20A9-4F3D-B6E0-446277564C3A}\\Client.exe"
      icon_index                   = 0
      assign_groups                = ["NV TechOps Role", "Physical Security Administrators", "Physical Security CCTV Users"]
    },
    {
      name                         = "VMSWebClient"
      group_name                   = "VMSWebClient"
      friendly_name                = "VMS Web Client"
      group_friendly_name          = "VMS Client Application Group"
      description                  = null
      path                         = "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe"
      command_line_argument_policy = "Require"
      command_line_arguments       = "http://vms.aadds.northvolt.com:8081/index.html"
      show_in_portal               = true
      icon_path                    = "C:\\Windows\\Installer\\{09ED1BB2-20A9-4F3D-B6E0-446277564C3A}\\Client.exe"
      icon_index                   = 0
      assign_groups                = ["NV TechOps Role", "Physical Security Administrators", "Physical Security CCTV Users"]
    },
    {
      name                         = "ARXClient"
      group_name                   = "ARXClient"
      friendly_name                = "ARX Client"
      group_friendly_name          = "ARX Application Group"
      description                  = null
      path                         = "C:\\Program Files\\ASSA\\ARX\\ARX Client.exe"
      command_line_argument_policy = "DoNotAllow"
      command_line_arguments       = ""
      show_in_portal               = true
      icon_path                    = "C:\\Program Files\\ASSA\\ARX\\ARX Client.exe"
      icon_index                   = 0
      assign_groups                = ["NV TechOps Role", "Physical Security ARX Users"]
    },
  ]
}
