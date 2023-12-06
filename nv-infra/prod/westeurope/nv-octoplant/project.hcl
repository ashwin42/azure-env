locals {
  setup_prefix               = "nv-octoplant"
  resource_group_name        = "nv-octoplant-rg"
  tags = {
    infrastructure-owner = "techops@northvolt.com"
    project              = "Octoplant Ett"
    jira                 = "TOC-1094"
  }
}
