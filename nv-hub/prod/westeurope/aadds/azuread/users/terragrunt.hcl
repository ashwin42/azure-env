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
      account_enabled      = true
      department           = "Service Accounts"
      display_name         = "Aadds"
      job_title            = "System Accounts"
      show_in_address_list = false
      user_principal_name  = "aadds@northvolt.com"
      groups               = ["AAD DC Administrators"]
    },
  ]
}

