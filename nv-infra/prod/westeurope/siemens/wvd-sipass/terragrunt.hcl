terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.2.28"
  #source = "../../../../../../tf-mod-azure/wvd/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name          = "nv_siemens"
  setup_prefix                 = "sipass"
  wvd_ws_friendly_name         = "Sipass Windows Virtual Desktop"
  wvd_location                 = "westeurope"
  default_desktop_display_name = "Remote Desktop"
}
