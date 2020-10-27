terraform {
}

dependency "global" {
  config_path = "../global"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix         = dependency.global.outputs.setup_prefix
  resource_group_name  = dependency.global.outputs.resource_group.name
  storage_account_name = "nv-pne-storage"
  containers_list = [
    { name = "nv-pne-ftp", access_type = "private" }
  ]
}
