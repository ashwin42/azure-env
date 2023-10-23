terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.9.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//wvd"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  name = "pne-tc8"
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
      name                = "${local.name}-avd-ws"
      resource_group_name = "nv-pnl-vms-rg"
      friendly_name       = "PNE TC8"
      tags = {
        project = "P480-5"
      }
    },
  ]
  host_pools = [
    {
      name                  = "${local.name}-vm1-hp"
      friendly_name         = "08.03 - 08.05, 08.07"
      custom_rdp_properties = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1;redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;"
      tags = {
        project = "P480-5"
      }
    },
  ]
  application_groups = [
    {
      name                         = "${local.name}-vm1-ag"
      host_pool_name               = "${local.name}-vm1-hp"
      workspace_name               = "${local.name}-avd-ws"
      friendly_name                = "08.03 - 08.05, 08.07"
      default_desktop_display_name = "08.03 - 08.05, 08.07"
      assign_groups = [
        "NV TechOps Role",
        "P&L Validation Labs PNE Virtual Desktop users",
        "NV-PNE-VPN-AP"
      ]
      tags = {
        project = "P480-5"
      }
    },
  ]
}
