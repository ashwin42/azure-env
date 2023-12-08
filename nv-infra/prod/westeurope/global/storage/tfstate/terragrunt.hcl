terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.9.6"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/storage/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}


inputs = {
  name                            = include.root.inputs.remote_state_azurerm_storage_account_name
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false

  containers = [
    {
      name        = include.root.inputs.remote_state_azurerm_container_name
      access_type = "private"
    },
  ]

  iam_assignments = {
    Contributor = {
      groups = [
        "NV TechOps Consultants Member",
      ],
    },
    "Reader and Data Access" = {
      groups = [
        "NV TechOps Read Member",
        "NV Aviatrix Admin"
      ],
      service_principals = [
        "Terraform pipeline Azure Resource Groups"
      ],
    },
  }
}
