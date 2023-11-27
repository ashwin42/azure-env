locals {
  resource_group_name = "octoplant-dwa-rg"
  tags = {
    infrastructure-owner    = "techops@northvolt.com"
    project                 = "Octoplant"
    jira                    = "NDW-748"
    business-unit           = "120 ESS Systems - AB"
    department              = "120001 ESS Engineering - AB"
    cost-center             = "301001013 Engineering- ESS PL"
    global-process-owner    = "arkadiusz.grochowski@northvolt.com"
    data-owner              = "arkadiusz.grochowski@northvolt.com, traian.butto@northvolt.com"
    system-owner            = "arkadiusz.grochowski@northvolt.com, traian.butto@northvolt.com"
    infrastructure-owner    = "techops@northvolt.com"
    recovery-time-objective = "Medium Priority"
  }
}
