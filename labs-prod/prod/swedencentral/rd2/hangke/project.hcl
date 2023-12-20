locals {
  resource_group_name = "rd2-hangke-rg"
  tags = {
    infrastructure-owner    = "techops@northvolt.com"
    project                 = "RD2 - Hangke"
    jira                    = "RD2-1085"
    business-unit           = "104 R&D - AB"
    department              = "100006 Manufacturing Engineering"
    cost-center             = "100006001 Manufacturing Engineering"
    global-process-owner    = "dennis.song@northvolt.com"
    data-owner              = "rory.mcgrath@northvolt.com"
    system-owner            = "rory.mcgrath@northvolt.com"
    recovery-time-objective = "Medium Priority"
  }
}

