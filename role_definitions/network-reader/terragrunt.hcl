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
            "microsoft.network/virtualnetworkgateways/getbgppeerstatus/action",
            "microsoft.network/virtualnetworkgateways/getlearnedroutes/action",
            "microsoft.network/virtualnetworkgateways/getadvertisedroutes/action",
            "microsoft.network/vpngateways/getbgppeerstatus/action",
            "Microsoft.ResourceHealth/availabilityStatuses/read",
            "Microsoft.Resources/subscriptions/resourceGroups/read",
          ]
        }
      ],
    },
  ]
}

