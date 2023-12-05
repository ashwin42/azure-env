terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.8.8"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/storage"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name                          = "nvliminalstorage"
  account_replication_type      = "LRS"
  public_network_access_enabled = true
  iam_assignments = {
    "Reader" = {
      groups = [
        "Liminal Azure Storage Table Data Contributor - Production",
      ],
    },
  }
  tables = [
    {
      name = "trainingcells"
      iam_assignments = {
        "Storage Table Data Contributor" = {
          groups = [
            "NV TechOps Role",
            "Liminal Azure Storage Table Data Contributor - Production",
          ],
        },
      }
    },
  ]
}
