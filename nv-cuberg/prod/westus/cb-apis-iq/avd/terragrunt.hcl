terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.7.35"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/wvd/"
}

include {
  path = find_in_parent_folders()
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
      name = "westus2-nv-cuberg-apis-iq-hp"
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

