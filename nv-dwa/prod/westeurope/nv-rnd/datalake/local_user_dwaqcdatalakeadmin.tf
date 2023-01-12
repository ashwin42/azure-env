/*
resource "azapi_resource" "dwaqcdatalakeadmin" {
  type        = "Microsoft.Storage/storageAccounts/localUsers@2021-09-01"
  parent_id = azurerm_storage_account.this["dwarndstorage"].id
  name = "dwaqcdatalakeadmin"

  body = jsonencode({
    properties = {
      hasSshPassword = true,
      homeDirectory = "dwarndstorage-dl/qc-testresults"
      hasSharedKey = true,
      hasSshKey = false,
      permissionScopes = [{
        permissions = "rwdlc",
        service = "blob",
        resourceName = "dwarndstorage-dl"
      }]
    }
  })

  depends_on = [
    azurerm_storage_account.this.id["dwarndstorage"]
  ]
}
*/

