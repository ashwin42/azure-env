terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.3.0"
  #source = "../../../../../../tf-mod-azure/resource_group/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  lock_resources = true
}
