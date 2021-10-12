terraform {
  source = "../../../../../../../tf-mod-azuread/users/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  users = [
    {
      account_enabled       = true
      business_phones       = ["+351910046683"]
      company_name          = "Siemens"
      department            = "NV-External"
      display_name          = "Fabio Vaz"
      given_name            = "Fabio"
      surname               = "Vaz"
      job_title             = "NV-External"
      mail_nickname         = "fabio.vaz"
      other_mails           = ["fabio.vaz@siemens.com"]
      show_in_address_list  = false
      usage_location        = "PT"
      user_principal_name   = "fabio.vaz@nv-external.com"
      password              = "NorthVolt123!"
      force_password_change = true
      groups                = ["AAD-Siemens-ASRS-VPN-ELIGIBLE"]
    },
  ]
}

