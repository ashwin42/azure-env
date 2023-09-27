terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//subscription?ref=v0.7.33"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/subscription"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  subscription_name = "NV_Gen_Infra"
  management_group  = "Managed"

  iam_assignments = {
    "Contributor" = {
      service_principals = [
        "aviatrix_controller_app_prod",
        "MoveCollection-ne-we-ne",
      ],
    },
    "User Access Administrator" = {
      service_principals = [
        "MS-PIM",
        "MoveCollection-ne-we-ne",
      ],
    },
  }

  resource_provider_registrations = [
    {
      name = "Microsoft.Synapse"
    },
    {
      name = "Microsoft.HybridCompute"
    },
    {
      name = "Microsoft.HybridConnectivity"
    },
    {
      name = "Microsoft.AzureArcData"
    },
  ]
}

