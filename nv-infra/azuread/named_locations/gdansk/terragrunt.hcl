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
      name = "Gdansk - Jeden"
      ip = [
        {
          ip_ranges = [
            "188.252.120.144/30",
            "85.219.139.46/32",
          ]
          trusted = true
        }
      ]
    },
    {
      name = "Gdansk - Koga"
      ip = [
        {
          ip_ranges = [
            "213.192.66.123/32",
          ]
          trusted = true
        }
      ]
    },
  ]
}

