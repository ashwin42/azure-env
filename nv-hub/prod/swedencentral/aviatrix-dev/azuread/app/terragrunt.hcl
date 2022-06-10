terraform {
  source = "github.com/northvolt/tf-mod-aviatrix//azuread-app?ref=v0.0.5"
  # source = "../../../../../../../tf-mod-aviatrix//azuread-app"
}

include "root" {
  path = find_in_parent_folders()
}

include "local" {
  path = "local.hcl"
}

inputs = {
  app_name    = "aviatrix_controller_app_dev"
  owner_names = ["none@northvolt.com", "hampus.rosvall@northvolt.com"]
}
