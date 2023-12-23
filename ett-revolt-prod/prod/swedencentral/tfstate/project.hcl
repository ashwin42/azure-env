locals {
  setup_prefix = basename(get_terragrunt_dir())
  #local_state_enabled          = true
  #remote_state_azurerm_enabled = false
  tags = {
    business-unit = "109 Digitalization IT - AB"
    department    = "109037 IT Common - AB"
    cost-center   = "109037064 IT Common - AB"
  }
}

