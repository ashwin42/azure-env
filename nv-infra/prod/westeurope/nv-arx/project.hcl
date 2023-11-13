locals {
  azurerm_provider_version   = ">= 2.31.0"
  terraform_required_version = ">= 1.0"
  azurerm_features           = {}
  tags = {
    infrastructure-owner = "techops@northvolt.com"
    project              = "ARX"
    jira                 = "TOC-1208"
    global-process-owner = "lina.jander@northvolt.com"
    data-owner           = "linn.flachsbinder@northvolt.com"
  }
}
