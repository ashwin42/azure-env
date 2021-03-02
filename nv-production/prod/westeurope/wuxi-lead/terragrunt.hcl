# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

## Generate an Azure provider block
#generate "provider" {
#  path      = "tg_generated_provider.tf"
#  if_exists = "overwrite"
#  contents  = <<EOF
#provider "azurerm" {
#  version         = "=2.49.0"
#  subscription_id = "0f5f2447-3af3-4bbf-98fb-ac9664f75bdc"
#  features {}
#}
#EOF
#}

inputs = {
  resource_group_name = "nv-wuxi-lead"

}
