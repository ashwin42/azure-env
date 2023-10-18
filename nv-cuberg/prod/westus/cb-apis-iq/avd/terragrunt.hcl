terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.7.39"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/wvd/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}


inputs = {
  resource_group_name = "cb-apis-iq-rg"
  workspaces = [
    {
      name          = "westus2-nv-cuberg-apis-iq-ws"
      friendly_name = "Cuberg APIS IQ"
    },
  ]

  host_pools = [
    {
      name                  = "westus2-nv-cuberg-apis-iq-hp"
      custom_rdp_properties = "drivestoredirect:s:*;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:1; redirectsmartcards:i:1;usbdevicestoredirect:s:*;enablecredsspsupport:i:1;use multimon:i:1;targetisaadjoined:i:1;enablerdsaadauth:i:1;"
    },
  ]

  application_groups = [
    {
      name                         = "westus2-nv-cuberg-apis-iq-ag"
      friendly_name                = "Cuberg APIS IQ Application Group"
      default_desktop_display_name = "APIS IQ"
      host_pool_name               = "westus2-nv-cuberg-apis-iq-hp"
      workspace_name               = "westus2-nv-cuberg-apis-iq-ws"
      assign_groups = [
        "NV TechOps Role",
        "Cuberg APIS IQ User Access",
      ]
    },
  ]
}

