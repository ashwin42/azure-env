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
      name = "Skellefteå - Ett"
      ip = [
        {
          ip_ranges = [
            "195.198.29.224/28",
          ]
          trusted = true
        }
      ]
    },
    {
      name = "Skellefteå - Barracks"
      ip = [
        {
          ip_ranges = [
            "194.218.0.8/29",
          ]
          trusted = true
        }
      ]
    },
  ]
}

