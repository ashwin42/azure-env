locals {
  resource_group_name           = "nv_labx"
  recovery_vault_name           = "labx-rv"
  recovery_vault_resource_group = "nv_labx"
  tags = {
    infrastructure-owner = "techops@northvolt.com"
    project              = "LabX"
    jira                 = "TOC-1208"
  }
}
