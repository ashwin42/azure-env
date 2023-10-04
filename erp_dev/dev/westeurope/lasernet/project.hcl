locals {
  project_name        = basename(get_terragrunt_dir())
  resource_group_name = local.project_name
  recovery_vault_name = "lasernet-rv"
  host_pool_name      = "lasernet-dev-hp"
  tags = {
    business-unit = "109 Digitalization IT - AB"
    department    = "109033 Business Systems"
    cost-center   = "109033054 ERP & Microsoft"
    system-owner  = "Dardan Imeri"
  }
}
