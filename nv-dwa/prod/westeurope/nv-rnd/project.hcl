locals {
  #local_state_enabled          = true
  #remote_state_azurerm_enabled = false
  setup_prefix               = basename(get_terragrunt_dir())
  tags = {
    business-unit = "306 R&D - PL"
    department    = "306065 R&D - PL"
    cost-center   = "306065083 R&D - PL"
  }
}

