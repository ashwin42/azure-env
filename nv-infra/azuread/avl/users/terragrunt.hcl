terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//users?ref=v1.0.0"
  #source = "../../../../../tf-mod-azuread/users/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  users = [
    {
      account_enabled       = true
      business_phones       = ["+433167871292"]
      company_name          = "AVL"
      department            = "NV-External"
      display_name          = "Bernhard Eisenberger"
      given_name            = "Bernhard"
      surname               = "Eisenberger"
      job_title             = "NV-External"
      mail_nickname         = "bernhard.eisenberger"
      other_mails           = ["bernhard.eisenberger@avl.com"]
      show_in_address_list  = false
      usage_location        = "DE"
      user_principal_name   = "bernhard.eisenberger@nv-external.com"
      password              = "NorthVolt123!"
      force_password_change = true
    },
    {
      account_enabled       = true
      business_phones       = ["+911244090300"]
      company_name          = "AVL"
      department            = "NV-External"
      display_name          = "Sunil Pasricha"
      given_name            = "Sunil"
      surname               = "Pasricha"
      job_title             = "NV-External"
      mail_nickname         = "sunil.pasricha"
      other_mails           = ["sunil.pasricha@avl.com"]
      show_in_address_list  = false
      usage_location        = "IN"
      user_principal_name   = "sunil.pasricha@nv-external.com"
      password              = "NorthVolt123!"
      force_password_change = true
    },
    {
      account_enabled       = true
      business_phones       = ["+433167873893"]
      company_name          = "AVL"
      department            = "NV-External"
      display_name          = "Bernhard Stummer"
      given_name            = "Bernhard"
      surname               = "Stummer"
      job_title             = "NV-External"
      mail_nickname         = "bernhard.stummer"
      other_mails           = ["bernhard.stummer@avl.com"]
      show_in_address_list  = false
      usage_location        = "DE"
      user_principal_name   = "bernhard.stummer@nv-external.com"
      password              = "NorthVolt123!"
      force_password_change = true
    },
    {
      account_enabled       = true
      business_phones       = ["+433167878032"]
      company_name          = "AVL"
      department            = "NV-External"
      display_name          = "Balazs Szilard"
      given_name            = "Balazs"
      surname               = "Szilard"
      job_title             = "NV-External"
      mail_nickname         = "balazs.szilard"
      other_mails           = ["balazs.szilard@avl.com"]
      show_in_address_list  = false
      usage_location        = "DE"
      user_principal_name   = "balazs.szilard@nv-external.com"
      password              = "NorthVolt123!"
      force_password_change = true
    },
  ]
}

