terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.8.5"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/storage/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}


inputs = {
  create_storage_account = true
  name                   = replace(lower(include.root.inputs.setup_prefix), "/[-_]/", "")
  azure_files_authentication = {
    directory_type = "AADDS"
  }

  file_shares = [
    {
      name  = "data",
      quota = 10
    },
    {
      name        = "testdatanorthvolt",
      quota       = 5120,
      access_tier = "TransactionOptimized"
      acl = [
        {
          id = "testdatanorthvolt-186082C6B20"
          access_policy = [
            {
              expiry      = "2023-02-07T13:57:54.1750000Z"
              permissions = "rwl"
              start       = "2023-01-31T13:57:54.1750000Z"
            }
          ]
        }
      ]
    }
  ]

  iam_assignments = {
    "Storage Blob Data Owner" = {
      groups = [
        "NV TechOps Role",
      ],
    }
    "Storage File Data SMB Share Contributor" = {
      groups = [
        "NV IT Service Support Member",
      ],
    }
    "Reader and Data Access" = {
      groups = [
        "NV IT Service Support Member",
      ],
    },
  }
}
