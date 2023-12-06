locals {
  setup_prefix        = "octoplant-labs"
  resource_group_name = "nv-octoplant-labs-rg"
  tags = {
    infrastructure-owner    = "techops@northvolt.com"
    project                 = "Octoplant Labs"
    jira                    = "TOC-1094"
    recovery-time-objective = "Medium Priority"
  }
}
