locals {
  resource_group_name = "nv-thousandeyes"
  recovery_vault_name = "nv-thousandeyes-rv"
  tags = {
    infrastructure-owner = "techops@northvolt.com"
    system-owner         = "eric.drugge-lundstrom@northvolt.com"
    business-unit        = "Business Unit 109 Digitalization IT - AB"
    department           = "Department 109035 Operations & Infrastructure - AB"
    cost-center          = "CostCenter 109035062 Network - AB"
    project              = "ThousandEyes"
    jira                 = "HELP-125020"
  }
}
