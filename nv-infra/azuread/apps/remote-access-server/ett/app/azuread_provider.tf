terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
      version = "2.16.0"
    }
  }
}

provider "azuread" {
  # Configuration options
}

