locals {
  project_name        = basename(get_terragrunt_dir())
  providers           = ["azurerm", "netbox"]
  resource_group_name = local.project_name
  recovery_vault_name = "nv-lasernet-rv"
  tags = {
    business-unit = "109 Digitalization IT - AB"
    department    = "109033 Business Systems"
    cost-center   = "109033054 ERP & Microsoft"
    system-owner  = "Dardan Imeri"
  }
}
