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
      name = "Västerås - P&L"
      ip = [
        {
          ip_ranges = [
            "62.20.20.216/29",
          ]
          trusted = true
        }
      ]
    },
    {
      name = "Västerås - S&E"
      ip = [
        {
          ip_ranges = [
            "31.15.32.92/30",
          ]
          trusted = true
        }
      ]
    },
    {
      name = "Västerås - R&D"
      ip = [
        {
          ip_ranges = [
            "62.20.57.64/29",
          ]
          trusted = true
        }
      ]
    },
    {
      name = "Västerås - Office Labs"
      ip = [
        {
          ip_ranges = [
            "213.50.54.192/28",
          ]
          trusted = true
        }
      ]
    },
  ]
}

