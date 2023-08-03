terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//availability_set?ref=v0.7.59"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//availability_set"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  availability_sets = [
    {
      name = "${include.root.inputs.resource_group_name}_avs"
    },
  ]
}
