terraform {
  source = "git::git@github.com:northvolt/tf-mod-aviatrix.git//azuread-controller-account?ref=v0.0.13"
  # source = "../../../../../../tf-mod-aviatrix/azuread-controller-account"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "app" {
  config_path = "../azuread/app"
}

inputs = {
  subscriptions = {
    "NV-Hub"                     = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
    "NV-BI-dev"                  = "4c463b9b-3bc8-465e-ab88-4a5c54498953"
    "NV-BI-prod"                 = "e7e87268-c6b6-415a-877c-2333a99c7c86"
    "ERP_Prod"                   = "810a32ab-57c8-430a-a3ba-83c5ad49e012"
    "Microsoft-Azure-northvolt0" = "f23047bd-1342-4fdf-a81c-00c91500455f"
    "NV_Gen_Infra"               = "11dd160f-0e01-4b4d-a7a0-59407e357777"
    "NV-D365-Dev"                = "bd728441-1b83-4daa-a72f-91d5dc6284f1"
    "NV-Production"              = "0f5f2447-3af3-4bbf-98fb-ac9664f75bdc"
  }
  application_id  = dependency.app.outputs.application_id
  directory_id    = dependency.app.outputs.tenant_id
  application_key = dependency.app.outputs.client_secret
}
