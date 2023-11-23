locals {
  recovery_vault_name = "nv-labs-qc-rv"
  resource_group_name = "nv-labs-qc"
  setup_prefix        = basename(get_terragrunt_dir())
  tags = {
    infrastructure-owner = "techops@northvolt.com"
    system-owner         = "nathan.zimmerman@northvolt.com"
    business-unit        = "151058 Quality Control - LA"
    department           = "151 Manufacturing Support - LA"
    cost-center          = "151058251 Quality Control - LA"
    project              = "Labs QC"
    jira                 = "TOC-1969"
  }
}

