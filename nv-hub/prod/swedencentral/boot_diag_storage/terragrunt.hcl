terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.2.32"
  #source = "../../../../../tf-mod-azure/storage"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  storage_account_name     = "nvhubgeneralstorage"
  resource_group_name      = "nv-hub-general-storage"
  create_resource_group    = true
  account_replication_type = "LRS"
  account_tier             = "Standard"
  account_kind             = "Storage"
  #enable_https_traffic_only = false
  enable_ad_auth = true
  tags           = { "ms-resource-usage" = "azure-cloud-shell" }
}

