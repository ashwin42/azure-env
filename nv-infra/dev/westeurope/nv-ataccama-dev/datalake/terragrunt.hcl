terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.7.20"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/storage"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name                          = "dlmasterdataataccamadev"
  is_hns_enabled                = true
  data_lake_owner_group         = "NV TechOps Consultants Member"

  data_lake_ace = [
    {
      scope       = "default"
      type        = "group"
      group       = "NV TechOps Consultants Member"
      permissions = "rwx"
    },
    {
      scope       = "default"
      type        = "group"
      group       = "NV TechOps Role"
      permissions = "rwx"
    }
  ]

  data_lake_path = [
    {
      path = "ataccama-data"
      ace = [
        {
          scope       = "default"
          type        = "group"
          group       = "NV TechOps Consultants Member"
          permissions = "rwx"
        },
        {
          scope       = "default"
          type        = "group"
          group       = "NV TechOps Role"
          permissions = "rwx"
        }
      ]
    }
  ]

  lifecycles = [
    {
      base_blob = {
        tier_to_cool_after_days    = 7
        tier_to_archive_after_days = 180
      }
    }
  ]

  network_rules = {
      name           = "default_rule"
      bypass         = ["AzureServices"]
      default_action = "Deny"
      ip_rules       = ["16.170.65.157","13.49.218.90"]
  }

  iam_assignments = {
    "Storage Account Contributor" = {
      groups = [
        "NV TechOps Consultants Member","NV TechOps Role"
      ],
    },
    "Storage Blob Data Contributor" = {
      groups = [
        "NV TechOps Consultants Member","NV TechOps Role"
      ],
    },
  }
}