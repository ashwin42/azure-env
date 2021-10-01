resource "azurerm_virtual_desktop_application_group" "cmx-dbmgr" {
  description         = "Desktop Application Group created with Terraform"
  friendly_name       = "nv-cmx-cmx-ag"
  host_pool_id        = azurerm_virtual_desktop_host_pool.pooled[0].id
  location            = "westeurope"
  name                = "CMX-DB-Mgr"
  resource_group_name = "nv-cmx-rg"
  tags = {
    "environment" = "prod"
    "module"      = "tf-mod-azure/wvd"
    "repo"        = "azure-env/nv-infra/prod/westeurope/nv-cmx/wvd"
  }
  type = "RemoteApp"
}

resource "azurerm_virtual_desktop_application" "cmx-dbmgr" {
  name                         = "CMX-DB-Mgr"
  application_group_id         = azurerm_virtual_desktop_application_group.cmx-dbmgr.id
  friendly_name                = "CMX Database Manager"
  description                  = null
  path                         = "C:\\Program Files (x86)\\CMX\\BxbDatabaseSetup.exe"
  command_line_argument_policy = "DoNotAllow"
  command_line_arguments       = ""
  show_in_portal               = true
  icon_path                    = "C:\\Program Files (x86)\\CMX\\Db_manager_32x32_16M_16c_v3.ico"
  icon_index                   = 0
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "cmx-dbmgr" {
  application_group_id = azurerm_virtual_desktop_application_group.cmx-dbmgr.id
  workspace_id         = azurerm_virtual_desktop_workspace.pooled[0].id
}

data "azurerm_role_definition" "cmx-dbmgr" {
  name  = "Desktop Virtualization User"
  scope = "/subscriptions/${var.subscription_id}"
}

resource "azurerm_role_assignment" "techops-cmx-dbmgr" {
  scope              = azurerm_virtual_desktop_application_group.cmx-dbmgr.id
  role_definition_id = data.azurerm_role_definition.cmx-dbmgr.id
  principal_id       = "7d2c7582-8c8a-4bcb-a5c6-3d265b9333bd"
}

resource "azurerm_role_assignment" "cmx-vpn-eligible-cmx-dbmgr" {
  scope              = azurerm_virtual_desktop_application_group.cmx-dbmgr.id
  role_definition_id = data.azurerm_role_definition.cmx-dbmgr.id
  principal_id       = "8b04ae8e-1dde-45f9-b67c-21528e722194"
}
