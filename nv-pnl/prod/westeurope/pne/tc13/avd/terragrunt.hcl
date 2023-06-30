terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.7.32"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//wvd"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  enable_wvd_hp_logs = true
  log = [
    {
      category = "Connection"
    },
  ]
  workspaces = [
    {
      name                = "pne-tc13-avd-ws"
      resource_group_name = "nv-pnl-vms-rg"
      friendly_name       = "PNE TC13"
      tags = {
        project = "LHW-19"
      }
    },
  ]
  host_pools = [
    {
      name                  = "pne-tc13-vm1-hp"
      friendly_name         = "13.01 - 13.10"
      custom_rdp_properties = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;"
      tags = {
        project = "LHW-19"
      }
    },
    {
      name                  = "pne-tc13-vm2-hp"
      friendly_name         = "13.11 - 13.20"
      custom_rdp_properties = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;"
      tags = {
        project = "LHW-19"
      }
    },
    {
      name                  = "pne-tc13-vm3-hp"
      friendly_name         = "13.21 - 13.25"
      custom_rdp_properties = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;"
      tags = {
        project = "LHW-19"
      }
    },
  ]
  application_groups = [
    {
      name                         = "pne-tc13-vm1-ag"
      host_pool_name               = "pne-tc13-vm1-hp"
      workspace_name               = "pne-tc13-avd-ws"
      friendly_name                = "13.01 - 13.10"
      default_desktop_display_name = "13.01 - 13.10"
      assign_groups = [
        "NV TechOps Role",
        "P&L Validation Labs PNE Virtual Desktop users",
        "NV-PNE-VPN-AP"
      ]
      tags = {
        project = "LHW-19"
      }
    },
    {
      name                         = "pne-tc13-vm2-ag"
      host_pool_name               = "pne-tc13-vm2-hp"
      workspace_name               = "pne-tc13-avd-ws"
      friendly_name                = "13.11 - 13.20"
      default_desktop_display_name = "13.11 - 13.20"
      assign_groups = [
        "NV TechOps Role",
        "P&L Validation Labs PNE Virtual Desktop users",
        "NV-PNE-VPN-AP"
      ]
      tags = {
        project = "LHW-19"
      }
    },
    {
      name                         = "pne-tc13-vm3-ag"
      host_pool_name               = "pne-tc13-vm3-hp"
      workspace_name               = "pne-tc13-avd-ws"
      friendly_name                = "13.21 - 13.25"
      default_desktop_display_name = "13.21 - 13.25"
      assign_groups = [
        "NV TechOps Role",
        "P&L Validation Labs PNE Virtual Desktop users",
        "NV-PNE-VPN-AP"
      ]
      tags = {
        project = "LHW-19"
      }
    },
  ]
}

