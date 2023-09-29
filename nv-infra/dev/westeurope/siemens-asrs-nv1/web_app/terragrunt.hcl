terraform {
}

dependency "global" {
  config_path = "../global"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  setup_prefix        = dependency.global.outputs.setup_prefix
  resource_group_name = dependency.global.outputs.resource_group.name
  subnet_id           = dependency.global.outputs.subnet["asrs-nv1-dev-subnet-10.44.5.176-28"].id
  subnet_id2          = dependency.global.outputs.subnet["asrs-nv1-dev-subnet-10.44.5.192-28"].id
}
