locals {
  netbox_role         = "wincc"
  resource_group_name = "revolt-scada-wincc"
  tags = {
    infrastructure-owner = "techops@northvolt.com"
    business-unit        = "119 Revolt - AB"
    department           = "350100 Program Team - RV"
    cost-center          = "350100001 RV Program"
    project              = "Revolt SCADA - WinCC"
    jira                 = "RV1-12"
  }
}

