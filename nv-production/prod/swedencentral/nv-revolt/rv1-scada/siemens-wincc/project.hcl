locals {
  azurerm_provider_version   = ">= 3.45"
  terraform_required_version = ">= 1.3.7"
  netbox_role                = "wincc"

  resource_group_name = "revolt-scada-wincc"
  tags = {
    business-unit = "119 Revolt - AB"
    department    = "350100 Program Team - RV"
    cost-center   = "350100001 RV Program"
    project       = "Revolt SCADA - WinCC"
    jira          = "RV1-12"
  }
}

