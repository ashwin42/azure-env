terraform {
}

dependency "global" {
  config_path = "../global"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix        = "${dependency.global.outputs.setup_prefix}-fa1"
  resource_group_name = dependency.global.outputs.resource_group.name
  subnet_id           = dependency.global.outputs.subnet["asrs-nv1-prod-subnet-10.46.0.0-27"].id
  subnet_id2          = dependency.global.outputs.subnet["asrs-nv1-prod-subnet-10.46.0.96-28"].id
}
