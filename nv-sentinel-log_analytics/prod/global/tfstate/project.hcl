locals {
  #local_state_enabled          = true
  #remote_state_azurerm_enabled = false
  setup_prefix = basename(get_terragrunt_dir())
  tags = {
    business-unit = "109 Digitalization IT - AB"
    department    = "109036 Security - AB"
    cost-center   = "109036064 Security - AB"
  }
}

