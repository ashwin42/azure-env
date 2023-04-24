terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//role_definitions?ref=v0.7.50"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/role_definitions/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  role_definitions = [
    {
      name                          = "Network Reader"
      description                   = "Provides read access on network resource"
      management_group_display_name = "NV Root"
      permissions = [
        {
          actions = [
            "Microsoft.Network/*/read",
            "Microsoft.Network/networkInterfaces/effectiveRouteTable/action",
            "Microsoft.ResourceHealth/availabilityStatuses/read",
            "Microsoft.Resources/subscriptions/resourceGroups/read",
          ]
        }
      ],
    },
  ]
}

