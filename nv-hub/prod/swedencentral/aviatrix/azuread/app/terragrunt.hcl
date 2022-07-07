terraform {
  source = "github.com/northvolt/tf-mod-aviatrix//azuread-app?ref=v0.0.13"
  # source = "../../../../../../../tf-mod-aviatrix//azuread-app"
}

include "root" {
  path = find_in_parent_folders()
}

include "local" {
  path = "local.hcl"
}

inputs = {
  app_name      = "aviatrix_controller_app_prod"
  owner_names   = ["none@northvolt.com", "hampus.rosvall@northvolt.com"]
  subscriptions = [
    "4312dfc3-8ec3-49c4-b95e-90a248341dd5", # NV-Hub
    "4c463b9b-3bc8-465e-ab88-4a5c54498953", # NV-BI-dev
    "e7e87268-c6b6-415a-877c-2333a99c7c86", # NV-BI-Prod
    "810a32ab-57c8-430a-a3ba-83c5ad49e012", # ERP_Prod
    "f23047bd-1342-4fdf-a81c-00c91500455f", # Microsoft Azure (northvolt0): #1000880
    "11dd160f-0e01-4b4d-a7a0-59407e357777", # NV_Gen_Infra
    "bd728441-1b83-4daa-a72f-91d5dc6284f1", # NV-D365-Dev
    "0f5f2447-3af3-4bbf-98fb-ac9664f75bdc", # NV-Production
  ]
}
