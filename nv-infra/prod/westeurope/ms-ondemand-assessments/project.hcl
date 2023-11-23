locals {
  resource_group_name = "ms-oda-rg"
  tags = {
    infrastructure-owner    = "techops@northvolt.com"
    system-owner            = "techops@northvolt.com"
    business-unit           = "109 Digitalization IT - AB"
    department              = "1109037 IT Common - AB"
    cost-center             = "109037064 IT Common - AB"
    project                 = "Microsoft On-Demand Assessments"
    jira                    = "TOC-2007"
    global-process-owner    = "N/A"
    data-owner              = "N/A"
    recovery-time-objective = "Low Priority"
  }
}

