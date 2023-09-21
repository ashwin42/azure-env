terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.8.3"
  #source = "../../../../../tf-mod-azure/storage"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  storage_account_name            = "nvhubgeneralstorage"
  resource_group_name             = "nv-hub-general-storage"
  create_resource_group           = true
  account_replication_type        = "LRS"
  account_tier                    = "Standard"
  account_kind                    = "Storage"
  enable_ad_auth                  = true
  account_replication_type        = "RAGRS"
  allow_nested_items_to_be_public = false

  azure_files_authentication = {
    directory_type = "AADDS"
  }

  identity = {
    type = "SystemAssigned"
  }

  network_rules = {
    default_action = "Allow"
  }

  containers = [
    {
      name = "packet-capture"
    },
  ]

  tags = merge(
    include.root.inputs.tags,
    { "ms-resource-usage" = "azure-cloud-shell" }
  )
}

