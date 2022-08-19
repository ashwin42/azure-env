terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//named_location?ref=v1.3.0"
  #source = "../../../../../tf-mod-azuread/named_location/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  named_locations = [
    {
      name = "Amsterdam - Azure WVD"
      ip = [
        {
          azure_ip_ranges = [
            "AzureCloud.westeurope",
          ]
          trusted = false
        }
      ]
    },
  ]
}

