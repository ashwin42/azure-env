locals {
  azurerm_provider_version               = ">=3.27.0"
  terraform_required_version             = ">= 1.2.6"
  azurerm_features                       = {}
  location                               = "swedencentral"
  setup_prefix                           = "loganalytics-rg"
  resource_group_name                    = "loganalytics-rg"
  log_analytics_workspace_name           = "log-analytics-ops-ws"
  log_analytics_workspace_resource_group = "loganalytics-rg"
}
