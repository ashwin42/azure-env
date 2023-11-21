terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.9.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/storage"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name                = "swctestdatalake"
  resource_group_name = "storage-rg"
  is_hns_enabled      = true
  sftp_enabled        = true

  iam_assignments = {
    "Storage Blob Data Owner" = {
      groups = [
        "NV TechOps Lead Role",
      ]
    }
  }


  data_lake_gen2_filesystems = [
    {
      name       = "swedencentral-dl"
      group_name = "NV TechOps Role"
      ace = [
        {
          group       = "NV TechOps Role"
          permissions = "rwx"
          scope       = "access"
          type        = "group"
        },
      ]
      iam_assignments = {
        "Storage Blob Data Contributor" = {
          groups = [
            "NV TechOps Role",
          ],
        },
      }

      local_users = [
        {
          name                 = "swcdladmin"
          home_directory       = "swedencentral-dl/homedir"
          ssh_password_enabled = true
          permission_scopes = [
            {
              resource_name = "swedencentral-dl"
              service       = "blob"

              permissions = {
                create = true
                delete = true
                list   = true
                read   = true
                write  = true
              }
            },
          ]
        },
      ]

      paths = [
        {
          path = "test-path"
        }
      ]
    },
  ]
}
