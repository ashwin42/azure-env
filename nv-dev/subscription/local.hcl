locals {
  # On first run, next two lines are uncommented, after tfstate storage is set, they should be commented
  #local_state_enabled          = true
  #remote_state_azurerm_enabled = false
  tags = {
    owner         = "techops@northvolt.com"
    business-unit = "109 Digitalization IT - AB"
    department    = "109035 Operations & Infrastructure - AB"
    cost-center   = "109035060 TechOps"
  }
}
