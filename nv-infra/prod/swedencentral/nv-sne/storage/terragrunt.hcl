terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.6.10"
  #source = "../../../tf-mod-azure/storage/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}


inputs = {
  name = replace(lower(include.root.inputs.setup_prefix), "/[-_]/", "")
  file_shares = [
    { name = "data", quota = 10 },
  ]
  iam_assignments = {
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
