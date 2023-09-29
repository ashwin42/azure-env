terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//users?ref=v1.3.4"
  #source = "${dirname(get_repo_root())}/tf-mod-azuread//users"
}

# Include all settings from the root terragrunt.hcl file
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  users = [
    {
      account_enabled       = true
      business_phones       = []
      company_name          = ""
      department            = "Service accounts"
      display_name          = "Siemens Physical Security Software Service Account"
      given_name            = ""
      surname               = ""
      job_title             = "Service Account"
      mail_nickname         = "sa-siemens-ps-ac"
      other_mails           = []
      show_in_address_list  = false
      usage_location        = "SE"
      user_principal_name   = "sa-siemens-ps-ac@northvolt.com"
      password              = "NorthVolt123!"
      force_password_change = true
      preferred_language    = "en-US"
    },
  ]
}

