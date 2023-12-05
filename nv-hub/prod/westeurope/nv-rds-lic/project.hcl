locals {
  setup_prefix        = "nv-rds-lic"
  resource_group_name = "nv-rds-lic"
  tags = {
    infrastructure-owner    = "techops@nortvolt.com"
    system-owner            = "techops@northvolt.com"
    recovery-time-objective = "Low Priority"
    project                 = "RDS License Server"
    jira                    = "TOC-1315"
    business-unit           = "109 Digitalization IT - AB"
    department              = "109037 IT Common - AB"
    cost-center             = "109037064 IT Common - AB"
  }
}

