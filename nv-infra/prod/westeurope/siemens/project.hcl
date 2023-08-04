locals {
  resource_group_name = "nv_siemens"
  recovery_vault_name = "nv-siemens-recovery-vault"

  tags = {
    business-unit = "109 Digitalization IT - AB"
    department    = "109035 Operations & Infrastructure - AB"
    cost-center   = "109035063 Operations & Infrastructure Common - AB"
    project       = "Siemens"
    jira          = "TOC-727"
  }
}
