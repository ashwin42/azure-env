resource "azurerm_virtual_desktop_application_group" "vms_client" {
  description         = "Desktop Application Group created with Terraform"
  friendly_name       = "VMS Client Application Group"
  host_pool_id        = azurerm_virtual_desktop_host_pool.pooled[0].id
  location            = "westeurope"
  name                = "VMSClient"
  resource_group_name = "nv_siemens"
  tags = {
    "environment" = "prod"
    "module"      = "tf-mod-azure/wvd"
    "repo"        = "azure-env/nv-infra/prod/westeurope/siemens/wvd-vms_client"
  }
  type = "RemoteApp"
}

resource "azurerm_virtual_desktop_application" "vms_client" {
  name                         = "VMSClient"
  application_group_id         = azurerm_virtual_desktop_application_group.vms_client.id
  friendly_name                = "VMS Client"
  description                  = null
  path                         = "C:\\Program Files\\Siemens\\Siveillance VMS Video Client\\Client.exe"
  command_line_argument_policy = "DoNotAllow"
  command_line_arguments       = ""
  show_in_portal               = true
  icon_path                    = "C:\\Windows\\Installer\\{09ED1BB2-20A9-4F3D-B6E0-446277564C3A}\\Client.exe"
  icon_index                   = 0
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "vms_client" {
  application_group_id = azurerm_virtual_desktop_application_group.vms_client.id
  workspace_id         = azurerm_virtual_desktop_workspace.pooled[0].id
}

data "azurerm_role_definition" "vms_client" {
  name  = "Desktop Virtualization User"
  scope = "/subscriptions/${var.subscription_id}"
}

resource "azurerm_role_assignment" "techops-vms_client" {
  scope              = azurerm_virtual_desktop_application_group.vms_client.id
  role_definition_id = data.azurerm_role_definition.vms_client.id
  principal_id       = "7d2c7582-8c8a-4bcb-a5c6-3d265b9333bd"
}

resource "azurerm_role_assignment" "vms_client-sipass_admins_cc" {
  scope              = azurerm_virtual_desktop_application_group.vms_client.id
  role_definition_id = data.azurerm_role_definition.vms_client.id
  principal_id       = "442cf778-3546-4531-bfa5-fe3cb68bde28"
}

resource "azurerm_role_assignment" "vms_client-sipass_users_cc" {
  scope              = azurerm_virtual_desktop_application_group.vms_client.id
  role_definition_id = data.azurerm_role_definition.vms_client.id
  principal_id       = "a799ad94-bce8-4235-8f32-4e271c7b3c0b"
}

