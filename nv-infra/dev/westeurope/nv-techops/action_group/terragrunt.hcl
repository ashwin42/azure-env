terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//action_group?ref=v0.3.03"
  #source = "../../../../../../tf-mod-azure/action_group/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix                  = "techops-monitoring"
  resource_group_name           = "techops-rg"
  action_group_name             = "techops-ag"
  action_group_short_name       = "techops"
  azuread_group                 = "NV TechOps Role"
}

