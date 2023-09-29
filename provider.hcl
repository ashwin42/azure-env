locals {
  log_analytics_workspace_id                    = "/subscriptions/4312dfc3-8ec3-49c4-b95e-90a248341dd5/resourceGroups/loganalytics-rg/providers/Microsoft.OperationalInsights/workspaces/log-analytics-ops-ws"
  log_analytics_subscription_id                 = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
  log_analytics_resource_group_name             = "loganalytics-rg"
  maintenance_configuration_resource_group_name = "patch_management"
  maintenance_configuration_subscription_id     = "11dd160f-0e01-4b4d-a7a0-59407e357777"
  remote_state_azurerm_enabled                  = true
  providers                                     = ["azurerm"]
  azurerm_features                              = {}
  ad_join_secrets_key_vault_rg                  = "nv-infra-core"
  ad_join_secrets_key_vault_name                = "nv-infra-core"
  ad_join_keyvault_subscription_id              = "11dd160f-0e01-4b4d-a7a0-59407e357777"

  # Standard images for VMs
  ubuntu_publisher         = "Canonical"
  ubuntu_offer_minimal_20  = "0001-com-ubuntu-minimal-focal-daily"
  ubuntu_sku_minimal_20    = "minimal-20_04-daily-lts"
  ubuntu_offer_minimal_22  = "0001-com-ubuntu-minimal-jammy-daily"
  ubuntu_sku_minimal_22    = "minimal-22_04-daily-lts"
  windows_server_offer     = "WindowsServer"
  windows_server_publisher = "MicrosoftWindowsServer"
  windows_server_sku_2019  = "2019-Datacenter"
  windows_server_sku_2022  = "2022-Datacenter"
}

