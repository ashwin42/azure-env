resource "azurerm_virtual_desktop_application_group" "sipass_oc" {
  description         = "Desktop Application Group created with Terraform"
  friendly_name       = "SiPass Operation Client Application Group"
  host_pool_id        = azurerm_virtual_desktop_host_pool.pooled[0].id
  location            = "westeurope"
  name                = "SiPassOC"
  resource_group_name = "nv_siemens"
  tags = {
    "environment" = "prod"
    "module"      = "tf-mod-azure/wvd"
    "repo"        = "azure-env/nv-infra/prod/westeurope/siemens/wvd-sipass_oc"
  }
  type = "RemoteApp"
}

resource "azurerm_virtual_desktop_application" "sipass_oc" {
  name                         = "SiPassOC"
  application_group_id         = azurerm_virtual_desktop_application_group.sipass_oc.id
  friendly_name                = "SiPass Operation Cient"
  description                  = null
  path                         = "C:\\Program Files (x86)\\SiPass integrated\\SiPassOpClient.exe"
  command_line_argument_policy = "DoNotAllow"
  command_line_arguments       = ""
  show_in_portal               = true
  icon_path                    = "C:\\Program Files (x86)\\SiPass integrated\\SiPassOpClient.exe"
  icon_index                   = 0
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "sipass_oc" {
  application_group_id = azurerm_virtual_desktop_application_group.sipass_oc.id
  workspace_id         = azurerm_virtual_desktop_workspace.pooled[0].id
}

data "azurerm_role_definition" "sipass_oc" {
  name  = "Desktop Virtualization User"
  scope = "/subscriptions/${var.subscription_id}"
}

resource "azurerm_role_assignment" "techops-sipass_oc" {
  scope              = azurerm_virtual_desktop_application_group.sipass_oc.id
  role_definition_id = data.azurerm_role_definition.sipass_oc.id
  principal_id       = "7d2c7582-8c8a-4bcb-a5c6-3d265b9333bd"
}

resource "azurerm_role_assignment" "sipass_oc-sipass_admins_oc" {
  scope              = azurerm_virtual_desktop_application_group.sipass_oc.id
  role_definition_id = data.azurerm_role_definition.sipass_oc.id
  principal_id       = "442cf778-3546-4531-bfa5-fe3cb68bde28"
}

resource "azurerm_role_assignment" "sipass_oc-sipass_users_oc" {
  scope              = azurerm_virtual_desktop_application_group.sipass_oc.id
  role_definition_id = data.azurerm_role_definition.sipass_oc.id
  principal_id       = "a799ad94-bce8-4235-8f32-4e271c7b3c0b"
}

