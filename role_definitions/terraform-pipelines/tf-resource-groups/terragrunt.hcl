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
      name                          = "Terraform Resource Groups Contributor"
      description                   = "Allows creation of resource groups and assignment of roles within them."
      management_group_display_name = "Managed"
      permissions = [
        {
          actions = [
            "Microsoft.Resources/subscriptions/resourceGroups/read",
            "Microsoft.Resources/subscriptions/resourceGroups/write",
            "Microsoft.Resources/subscriptions/resourceGroups/delete",
            "Microsoft.Authorization/roleAssignments/*"
          ]
        }
      ],
    },
  ]
}

