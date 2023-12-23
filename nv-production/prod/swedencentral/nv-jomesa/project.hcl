locals {
  project             = basename(get_terragrunt_dir())
  resource_group_name = local.project
  providers           = ["azurerm"]
  tags = {
    infrastructure-owner    = "techops@northvolt.com"
    project                 = "Jomesa"
    jira                    = "HELP-130049"
    global-process-owner    = "Techops"
    data-owner              = "Techops"
    infrastructure-owner    = "Techops"
    system-owner            = "Techops"
    business-unit           = "109 Digitalization IT - AB"
    department              = "109037 IT Common - AB"
    cost-center             = "109037064 IT Common - AB"
    recovery-time-objective = "24h"
  }
}
