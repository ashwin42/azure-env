locals {
  project             = "tomteboda-builddata"
  resource_group_name = local.project
  tags = {
    project                 = "Tomteboda BuildData SQL"
    jira                    = "HELP-132205"
    infrastructure-owner    = "techops@northvolt.com"
    business-unit           = "250 Northvolt Battery Systems - BS"
    department              = "250006 Manufacturing & Industrialization Engineering - BS"
    cost-center             = "250006019 Automation, Control & Manufacturing Data Solutions - BS"
    system-owner            = "kassem.al-harakeh@northvolt.com, saqib.shah@northvolt.com"
    data-owner              = "kassem.al-harakeh@northvolt.com, saqib.shah@northvolt.com"
    global-process-owner    = "kassem.al-harakeh@northvolt.com, saqib.shah@northvolt.com"
    recovery-time-objective = "Medium Priority"
  }
}
