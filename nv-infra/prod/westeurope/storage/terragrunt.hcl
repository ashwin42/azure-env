include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name = "nv-infra-core"
  default_tags        = { repo = "azure-env/nv-infra/02_global" }
}
