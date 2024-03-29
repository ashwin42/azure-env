locals {
  resource_group_name = "bastion-rg"
  tags = {
    infrastructure-owner    = "techops@northvolt.com"
    business-unit           = "109 Digitalization IT - AB"
    department              = "109035 Operations & Infrastructure - AB"
    cost-center             = "109035060 TechOps"
    project                 = "Bastion"
    jira                    = "TOC-2404"
    system-owner            = "techops@nortvolt.com"
    global-process-owner    = "N/A"
    data-owner              = "N/A"
    recovery-time-objective = "Medium Priority"
  }
}
