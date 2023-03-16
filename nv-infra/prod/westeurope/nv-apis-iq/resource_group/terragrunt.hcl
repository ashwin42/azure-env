terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.7.46"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/resource_group/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  lock_resources = true
}

