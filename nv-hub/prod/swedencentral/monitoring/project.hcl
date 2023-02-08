locals {
  setup_prefix                           = "loganalytics-rg"
  resource_group_name                    = "loganalytics-rg"
  log_analytics_workspace_name           = "log-analytics-ops-ws"
  log_analytics_workspace_resource_group = "loganalytics-rg"
  tags = {
    business-unit = "109 Digitalization IT - AB"
    department    = "109035 Operations & Infrastructure - AB"
    cost-center   = "109035060 TechOps"
  }
}
