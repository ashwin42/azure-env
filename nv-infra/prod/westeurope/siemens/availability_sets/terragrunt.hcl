terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//availability_set?ref=v0.2.28"
  #source = "../../../../../../tf-mod-azure/availability_set/"
}

dependency "global" {
  config_path = "../global"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  availability_sets = [
    {
      name                = "${dependency.global.outputs.resource_group.name}_avs"
      resource_group_name = dependency.global.outputs.resource_group.name
    },
  ]
}
