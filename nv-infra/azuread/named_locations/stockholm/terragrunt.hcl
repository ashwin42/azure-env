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
      name = "Stockholm - Liljeholmen Lab"
      ip = [
        {
          ip_ranges = [
            "194.18.85.192/29",
          ]
          trusted = true
        }
      ]
    },
    {
      name = "Stockholm - Volthouse"
      ip = [
        {
          ip_ranges = [
            "98.128.134.220/30",
          ]
          trusted = true
        }
      ]
    },
  ]
}

