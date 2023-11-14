locals {
  # azurerm_provider_version   = ">=3.2.6"
  # terraform_required_version = ">= 1.2.6"
  # azurerm_features           = {}
  setup_prefix        = "nv-rds-lic"
  resource_group_name = "nv-rds-lic"
  tags = {
    infrastructure-owner    = "techops@nortvolt.com"
    project                 = "RDS License Server"
    jira                    = "TOC-1315"
    business-unit           = "109 Digitalization IT - AB"
    department              = "109037 IT Common - AB"
    cost-center             = "109037064 IT Common - AB"
    system-owner            = "techops@northvolt.com"
    global-process-owner    = "N/A"
    data-owner              = "N/A"
    recovery-time-objective = "Business Continuity"
  }
}

