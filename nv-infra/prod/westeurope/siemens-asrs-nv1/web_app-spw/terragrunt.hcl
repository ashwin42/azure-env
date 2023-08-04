terraform {
}

dependency "vnet" {
  config_path = "../vnet"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix = "asrs-nv1-prod-spw"
  subnet_id    = dependency.vnet.outputs.subnets["asrs-nv1-prod-subnet-10.46.0.0-27"].id
  subnet_id2   = dependency.vnet.outputs.subnets["asrs-nv1-prod-subnet-10.46.0.112-28"].id
}
