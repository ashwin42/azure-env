resource "azurerm_storage_account" "northvolt_iot" {
  name                     = "northvoltiot"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  enable_advanced_threat_protection = true
}

resource "azurerm_storage_container" "northvolt_iot_test" {
  name                  = "test"
  storage_account_name  = azurerm_storage_account.northvolt_iot.name
  container_access_type = "private"
}

resource "azurerm_iothub" "northvolt_iot" {
  name                = "northvolt-iot"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  sku {
    name     = "S1"
    tier     = "Standard"
    capacity = "1"
  }

  endpoint {
    type                       = "AzureIotHub.StorageContainer"
    connection_string          = azurerm_storage_account.northvolt_iot.primary_blob_connection_string
    name                       = "export"
    batch_frequency_in_seconds = 60
    max_chunk_size_in_bytes    = 10485760
    container_name             = "test"
    encoding                   = "Avro"
    file_name_format           = "{iothub}/{partition}_{YYYY}_{MM}_{DD}_{HH}_{mm}"
  }

  route {
    name           = "export"
    source         = "DeviceMessages"
    condition      = "true"
    endpoint_names = ["export"]
    enabled        = true
  }

  tags = {
    purpose = "testing"
  }
}

