locals {
  setup_prefix = basename(get_terragrunt_dir())
  tags = {
    project                 = "RND"
    jira                    = "TOC-1635"
    business-unit           = "306 R&D - PL"
    department              = "306065 R&D - PL"
    cost-center             = "306065083 R&D - PL"
    infrastructure-owner    = "techops@northvolt.com"
    system-owner            = "cezary.swinarski@northvolt.com"
    recovery-time-objective = "Medium Priority"
  }
}

