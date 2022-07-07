generate "provider_azuread" {
  path      = "tg_generated_provider_azuread.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "azuread" {}
EOF
}

generate "versions_override_azuread" {
  path      = "tg_generated_versions_azuread_override.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
      version = "2.16.0"
    }
  }
}
EOF
}
