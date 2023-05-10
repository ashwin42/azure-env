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
      name                          = "Subscriptions Alias Reader"
      management_group_display_name = "Self Managed"
      permissions = [
        {
          actions = [
            "Microsoft.Subscription/aliases/read"
          ]
        }
      ],
    },
  ]
}
