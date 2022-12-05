terraform {
  #source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.7.20"
  source = "${dirname(get_repo_root())}/tf-mod-azure/storage"
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
  name                = "dwarndstorage"
  resource_group_name = dependency.rg.outputs.resource_group_name
  subnet_id           = dependency.vnet.outputs.subnet["general_subnet1"].id
  containers_list = [
    { name = "qc-testresults", access_type = "private" }
  ]

  is_hns_enabled        = true
  data_lake_owner_group = "NV TechOps Role"
  data_lake_ace = [
    {
      scope       = "default"
      type        = "group"
      group       = "Dwa RND Data Lake Storage Admin"
      permissions = "rwx"
    }
  ]

  lifecycles = [
    {
      base_blob = {
        tier_to_archive_after_days = 1095
        delete_after_days          = 4380
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
      ],
    },
  }
}