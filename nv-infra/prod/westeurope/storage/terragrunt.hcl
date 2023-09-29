include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  resource_group_name = "nv-infra-core"
  default_tags        = { repo = "azure-env/nv-infra/02_global" }
}
