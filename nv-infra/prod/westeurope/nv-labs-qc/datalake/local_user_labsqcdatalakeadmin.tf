/*
resource "azapi_resource" "labsqcdatalakeadmin" {
  type        = "Microsoft.Storage/storageAccounts/localUsers@2021-09-01"
  parent_id = azurerm_storage_account.this["dwarndstorage"].id
  name = "dwaqcdatalakeadmin"
  body = jsonencode({
    properties = {
      hasSshPassword = true,
      homeDirectory = "labsqcstorage-dl/qc-testresults"
      hasSharedKey = true,
      hasSshKey = false,
      permissionScopes = [{
        permissions = "rwdlc",
        service = "blob",
        resourceName = "labsqcstorage-dl"
      }]
    }
  })
  depends_on = [
    azurerm_storage_account.this.id["labsqcstorage"]
  ]
}
*/

