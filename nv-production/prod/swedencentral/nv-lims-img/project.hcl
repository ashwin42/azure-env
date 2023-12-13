locals {
  setup_prefix = basename(get_terragrunt_dir())
  tags = {
    project                 = "LIMS"
    jira                    = "LIMS-5"
    business-unit           = ""
    department              = ""
    cost-center             = ""
    infrastructure-owner    = "techops@northvolt.com"
    system-owner            = "per.spaak@northvolt.com"
    recovery-time-objective = "Medium Priority"
  }
}

