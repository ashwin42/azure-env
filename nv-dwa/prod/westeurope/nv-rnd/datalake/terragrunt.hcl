terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.7.14"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/storage"
}

dependency "vnet" {
  config_path = "../../global/vnet"
}

dependency "rg" {
  config_path = "../resource_group"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name                = "rnd-datalake"
  resource_group_name = "nv-rnd"
  subnet_id           = dependency.global.outputs.subnet["subnet1"].id
  containers_list = [
    { name = "rnd-storage", access_type = "private" }
  ]

  is_hns_enabled        = true
  data_lake_owner_group = "NV TechOps Role"
  data_lake_ace = [
    {
      scope       = "access"
      type        = "group"
      user        = "Department 306065 R&D - PL"
      permissions = "rwx"
    }
  ]

  lifecycles = [
    {
      base_blob = {
        tier_to_archive_after_days = 60
        delete_after_days          = 1885
      }
    }
  ]

  iam_assignments = {
    "Storage Account Contributor" = {
      groups = [
        "NV TechOps Role",
      ],
    },
    "Storage Blob Data Contributor" = {
      groups = [
        "NV TechOps Role",
        "Department 306065 R&D - PL",
      ],
    },
    "Storage Blob Data Reader" = {
      groups = [
        "NV TechOps Role",
        "Department 306065 R&D - PL",
      ],
    },
  }
}