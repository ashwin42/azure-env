locals {
  setup_prefix        = basename(get_terragrunt_dir())
  resource_group_name = "${local.setup_prefix}-rg"
  tags = {
    infrastructure-owner    = "techops@northvolt.com"
    project                 = "BI Tomteboda"
    jira                    = "TOC-1761"
    system-owner            = "yew-onn.pang@northvolt.com"
    data-owner              = "yew-onn.pang@northvolt.com"
    department              = "250006 Manufacturing & Industrialization Engineering - BS"
    business-unit           = "250 Northvolt Battery Systems - BS"
    cost-center             = "250006019 Automation, Control & Manufacturing Data Solutions - BS"
    recovery-time-objective = "Medium Priority"
  }
}
