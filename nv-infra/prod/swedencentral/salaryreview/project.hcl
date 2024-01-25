locals {
  project             = basename(get_terragrunt_dir())
  resource_group_name = local.project
  tags = {
    business-unit           = "109 Digitalization IT - AB"
    department              = "109035 Operations & Infrastructure - AB"
    cost-center             = "109035061 Tools & Products"
    jira                    = "HELP-138167"
    project                 = "Salary Review App"
    infrastructure-owner    = "techops@northvolt.com"
    system-owner            = "ermal@northvolt.com"
    data-owner              = "dylan.taplin@northvolt.com"
    global-process-owner    = "dylan.taplin@northvolt.com"
    recovery-time-objective = "Low Priority"
  }
}
