locals {
  resource_group_name = "rd2-hangke-rg"
  tags = {
    infrastructure-owner    = "techops@northvolt.com"
    project                 = "RD2 - Hangke"
    jira                    = "RD2-1085"
    business-unit           = "150 Manufacturing Downstream - LA"
    department              = "150051 Formation and Aging - LA"
    cost-center             = "150051904 Prismatic Formation & Aging - LA"
    recovery-time-objective = "Medium Priority"
  }
}

