locals {
  azurerm_provider_version   = ">= 3"
  terraform_required_version = ">= 1.1"
  azurerm_features           = {}
  setup_prefix               = "autodesk-vault"
  resource_group_name        = "autodesk-vault-rg"
  install_winrm              = true
  netbox_role                = "autodeskvault"
  providers                  = ["azurerm", "netbox"]
  tags = {
    business-unit = "111 COO - Adv Tech - Raw Mat & Energy - AB"
    department    = "111044 Blueprint - AB"
    cost-center   = "111044080 Blueprint - AB"
    project       = "Autodesk Vault"
    jira          = "TOC-917"
  }
}

