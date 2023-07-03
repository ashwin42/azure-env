terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.7.32"
  #source = "../../../../../../tf-mod-azure/resource_group/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  lock_resources = false
  role_assignements = [
    {
      role_name = "Owner"
      groups    = ["AWS Admins"]
    },
    {
      role_name = "Key Vault Administrator"
      groups    = ["AWS Admins"]
    },
  ]
}

