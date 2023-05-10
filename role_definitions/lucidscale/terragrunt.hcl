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
      name                          = "Lucidscale import"
      description                   = "Role that gives Lucidscale read access to import resources"
      management_group_display_name = "Tenant Root Group"
      permissions = [
        {
          actions = [
            "Microsoft.Authorization/roleAssignments/read",
            "Microsoft.ApiManagement/service/read",
            "Microsoft.Compute/disks/read",
            "Microsoft.Compute/virtualMachines/read",
            "Microsoft.Compute/virtualMachineScaleSets/read",
            "Microsoft.Databricks/workspaces/read",
            "Microsoft.DBforMySQL/servers/databases/read",
            "Microsoft.DBforMySQL/servers/read",
            "Microsoft.DBforPostgreSQL/servers/databases/read",
            "Microsoft.DBforPostgreSQL/servers/read",
            "Microsoft.DocumentDB/databaseAccounts/read",
            "Microsoft.KeyVault/vaults/read",
            "Microsoft.ManagedIdentity/userAssignedIdentities/read",
            "Microsoft.Network/applicationGateways/read",
            "Microsoft.Network/azurefirewalls/read",
            "Microsoft.Network/connections/read",
            "Microsoft.Network/dnszones/read",
            "Microsoft.Network/dnszones/recordsets/read",
            "Microsoft.Network/frontDoors/read",
            "Microsoft.Network/loadBalancers/read",
            "Microsoft.Network/localnetworkgateways/read",
            "Microsoft.Network/networkInterfaces/read",
            "Microsoft.Network/networkSecurityGroups/read",
            "Microsoft.Network/privateDnsZones/read",
            "Microsoft.Network/privateDnsZones/ALL/read",
            "Microsoft.Network/privateDnsZones/virtualNetworkLinks/read",
            "Microsoft.Network/privateEndpoints/read",
            "Microsoft.Network/publicIPAddresses/read",
            "Microsoft.Network/routeTables/read",
            "Microsoft.Network/trafficManagerProfiles/read",
            "Microsoft.Network/virtualNetworkGateways/read",
            "Microsoft.Network/virtualNetworks/read",
            "Microsoft.Network/virtualNetworks/subnets/read",
            "Microsoft.Resources/subscriptions/read",
            "Microsoft.Resources/subscriptions/resourceGroups/read",
            "Microsoft.ServiceBus/namespaces/read",
            "Microsoft.ServiceBus/namespaces/queues/read",
            "Microsoft.Sql/servers/databases/read",
            "Microsoft.Sql/servers/read",
            "Microsoft.Storage/storageAccounts/read",
            "Microsoft.Web/serverfarms/Read",
            "microsoft.web/sites/functions/read",
            "Microsoft.Web/sites/Read"
          ]
        }
      ],
    },
  ]
}

