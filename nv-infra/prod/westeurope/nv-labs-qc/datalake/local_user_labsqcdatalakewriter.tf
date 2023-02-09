/*
resource "azapi_resource" "labsqcdatalakewriter" {
  type        = "Microsoft.Storage/storageAccounts/localUsers@2021-09-01"
  parent_id = azurerm_storage_account.this["dwarndstorage"].id
  name = "labsqcdatalakewriter"
  body = jsonencode({
    properties = {
      hasSshPassword = true,
      homeDirectory = "labsqcstorage-dl/qc-testresults"
      hasSharedKey = true,
      hasSshKey = false,
      permissionScopes = [{
        permissions = "wlc",
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