terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.0.1"
    }
  }
}

provider "azuread" {
  # Configuration options
}
