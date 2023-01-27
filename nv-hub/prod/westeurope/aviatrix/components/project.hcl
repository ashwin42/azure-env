locals {
  azurerm_provider_version   = ">=2.66.0"
  terraform_required_version = ">= 1.1"
  setup_prefix               = "avx-prod-sc"
  resource_group_name        = "avx-prod-sc-rg"
}

generate "provider_aviatrix" {
  path      = "tg_generated_provider_aviatrix.tf"
  if_exists = "overwrite"
  contents  = <<EOF
data "azurerm_key_vault" "this" {
  name  = "nv-hub-core"
  resource_group_name = "nv-hub-core"
}

data "azurerm_key_vault_secret" "avx-controller" {
  name         = "avx-controller"
  key_vault_id = data.azurerm_key_vault.this.id
}

provider "aviatrix" {
  controller_ip           = "13.53.36.212"
  username                = "admin"
  password                = data.azurerm_key_vault_secret.avx-controller.value
}
EOF
}

generate "versions_override_aviatrix" {
  path      = "tg_generated_versions_aviatrix_override.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    aviatrix = {
      source = "AviatrixSystems/aviatrix"
      version = ">= 2.22.0"
    }
  }
}
EOF
}
