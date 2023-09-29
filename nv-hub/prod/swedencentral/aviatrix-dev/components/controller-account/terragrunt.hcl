include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "app" {
  config_path = "../../azuread/app"
}

inputs = {
  application_id  = dependency.app.outputs.application_id
  subscription_id = dependency.app.outputs.subscription_id
  directory_id    = dependency.app.outputs.tenant_id
}