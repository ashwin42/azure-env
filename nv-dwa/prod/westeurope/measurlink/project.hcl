locals {
  resource_group_name = "measurlink-dwa-rg"
  tags = {
    infrastructure-owner    = "techops@northvolt.com"
    project                 = "Measurlink"
    jira                    = "NDW-734"
    business-unit           = "305 - Quality - PL"
    department              = "305064 - Quality - PL"
    cost-center             = "05064013 Quality - ESS PL"
    global-process-owner    = "shahin.ghazinouri@northvolt.com"
    data-owner              = "piotr.skupien@northvolt.com"
    system-owner            = "piotr.skupien@northvolt.com"
    infrastructure-owner    = "techops@northvolt.com"
    recovery-time-objective = "Medium Priority"
  }
}
