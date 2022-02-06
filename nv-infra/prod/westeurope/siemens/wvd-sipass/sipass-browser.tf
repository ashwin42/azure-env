resource "azurerm_virtual_desktop_application_group" "sipass_browser" {
  description         = "Desktop Application Group created with Terraform"
  friendly_name       = "SiPass integrated Web Client Application Group"
  host_pool_id        = azurerm_virtual_desktop_host_pool.pooled[0].id
  location            = "westeurope"
  name                = "SiPassBrowser"
  resource_group_name = "nv_siemens"
  tags = {
    "environment" = "prod"
    "module"      = "tf-mod-azure/wvd"
    "repo"        = "azure-env/nv-infra/prod/westeurope/siemens/wvd-sipass_browser"
  }
  type = "RemoteApp"
}

resource "azurerm_virtual_desktop_application" "sipass_browser" {
  name                         = "SiPassBrowser"
  application_group_id         = azurerm_virtual_desktop_application_group.sipass_browser.id
  friendly_name                = "SiPass integrated Web Client"
  description                  = null
  path                         = "C:\\Program Files\\Internet Explorer\\iexplore.exe"
  command_line_argument_policy = "Require"
  command_line_arguments       = "https://sipass.aadds.northvolt.com:5443/SiPass/#/"
  show_in_portal               = true
  icon_path                    = "C:\\Program Files\\Internet Explorer\\iexplore.exe"
  icon_index                   = 0
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "sipass_browser" {
  application_group_id = azurerm_virtual_desktop_application_group.sipass_browser.id
  workspace_id         = azurerm_virtual_desktop_workspace.pooled[0].id
}

data "azurerm_role_definition" "sipass_browser" {
  name  = "Desktop Virtualization User"
  scope = "/subscriptions/${var.subscription_id}"
}

resource "azurerm_role_assignment" "techops-sipass_browser" {
  scope              = azurerm_virtual_desktop_application_group.sipass_browser.id
  role_definition_id = data.azurerm_role_definition.sipass_browser.id
  principal_id       = "7d2c7582-8c8a-4bcb-a5c6-3d265b9333bd"
}

resource "azurerm_role_assignment" "sipass_browser-sipass_admins_browser" {
  scope              = azurerm_virtual_desktop_application_group.sipass_browser.id
  role_definition_id = data.azurerm_role_definition.sipass_browser.id
  principal_id       = "442cf778-3546-4531-bfa5-fe3cb68bde28"
}

resource "azurerm_role_assignment" "sipass_browser-sipass_users_browser" {
  scope              = azurerm_virtual_desktop_application_group.sipass_browser.id
  role_definition_id = data.azurerm_role_definition.sipass_browser.id
  principal_id       = "a799ad94-bce8-4235-8f32-4e271c7b3c0b"
}

