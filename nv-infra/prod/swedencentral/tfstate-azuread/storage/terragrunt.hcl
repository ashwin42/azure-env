terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.6.10"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/storage/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}


inputs = {
  name = replace(lower(include.root.inputs.setup_prefix), "/[-_]/", "")
  containers_list = [
    { name = "nv-tf-state", access_type = "private" }
  ]
  iam_assignments = {
    "Reader and Data Access" = {
      groups = [
        "NV IT Core Role",
        "NV TechOps Read Member"
      ],
      service_principals = [
        "Terraform pipeline AzureAD",
        "Terraform pipeline Azure Resource Groups",
        "Terraform pipeline Azure Identity Governance",
      ],
    },
  }
}
