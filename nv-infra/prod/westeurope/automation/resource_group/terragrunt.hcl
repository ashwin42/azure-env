terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.8.6"
}

include {
  path = find_in_parent_folders()
}
