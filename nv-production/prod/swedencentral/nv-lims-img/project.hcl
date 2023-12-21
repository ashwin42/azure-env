locals {
  setup_prefix = basename(get_terragrunt_dir())
  tags = {
    project                 = "LIMS"
    jira                    = "LIMS-5"
    business-unit           = "109 - Digitalization IT - AB"
    department              = "109033 - Business Systems"
    cost-center             = "109033056 - LIMS"
    infrastructure-owner    = "techops@northvolt.com"
    system-owner            = "per.spaak@northvolt.com"
    recovery-time-objective = "Medium Priority"
  }
}

