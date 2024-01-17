locals {
  setup_prefix        = "nv-octoplant"
  resource_group_name = "nv-octoplant-rg"
  tags = {
    infrastructure-owner    = "techops@northvolt.com"
    project                 = "Octoplant Ett"
    jira                    = "TOC-1094"
    business-unit           = "217 - Engineering - ET"
    department              = "217008 - Industrial Automation - ET"
    cost-center             = "217008001 Industrial Automation - ET"
    global-process-owner    = "sebasthian.viotto@northvolt.com"
    data-owner              = "ivando.lossio@northvolt.com"
    system-owner            = "andrzej.tkaczynski@northvolt.com"
    recovery-time-objective = "Medium Priority"
  }
}
