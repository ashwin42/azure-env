locals {
  netbox_role         = "intralog"
  resource_group_name = "revolt-wcs-intralog"
  tags = {
    infrastructure-owner = "techops@northvolt.com"
    business-unit        = "119 Revolt - AB"
    department           = "350100 Program Team - RV"
    cost-center          = "350100001 RV Program"
    project              = "Revolt WCS Intralog"
    jira                 = "RV1-11"
  }
}

