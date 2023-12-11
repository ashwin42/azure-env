terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.9.6"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/storage"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name                      = basename(get_terragrunt_dir())
  account_kind              = "Storage"
  account_replication_type  = "LRS"
  enable_https_traffic_only = false
  tags = merge(
    include.root.inputs.tags,
    { "ms-resource-usage" = "azure-cloud-shell" }
  )
}
