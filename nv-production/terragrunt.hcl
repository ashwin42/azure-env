locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl", find_in_parent_folders("fallback.hcl")))

  # Automatically load local-level variables
  local_vars = read_terragrunt_config("local.hcl", read_terragrunt_config(find_in_parent_folders("fallback.hcl")))

  # Extract the variables we need for easy access
  subscription_name = local.account_vars.locals.subscription_name
  subscription_id   = local.account_vars.locals.subscription_id
  location          = lookup(local.region_vars.locals, "location", null) == null ? "" : local.region_vars.locals.location
  environment       = local.environment_vars.locals.environment
}

# Delete existing provider.tf
generate "provider-delete" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = ""
}

# Delete existing backend.tf
generate "backend-delete" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = ""
}

# Delete existing versions.tf
generate "versions-delete" {
  path      = "versions.tf"
  if_exists = "overwrite"
  contents  = ""
}

# Generate an Azure provider block
generate "provider" {
  path      = "tg_generated_provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "azurerm" {
  version         = "${local.local_vars.locals.azurerm_provider_version}"
  subscription_id = "${local.subscription_id}"
  ${local.local_vars.locals.azurerm_features}
}
EOF
}

# Configure bucket
remote_state {
  backend = "azurerm"
  generate = {
    path      = "tg_generated_backend.tf"
    if_exists = "overwrite"
  }

  config = {
    storage_account_name = local.account_vars.locals.remote_state_storage_account_name
    container_name       = local.account_vars.locals.remote_state_container_name
    key                  = "${local.account_vars.locals.subscription_name}/${path_relative_to_include()}/terraform.tfstate"
    resource_group_name  = local.account_vars.locals.remote_state_resource_group_name
    subscription_id      = local.subscription_id
  }
}

# Configure versions
generate "versions" {
  path      = "tg_generated_versions.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_version = "${local.local_vars.locals.terraform_required_version}"
}
EOF
}

inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals,
  { repo_tag = { "repo" : "azure-env/${basename(get_parent_terragrunt_dir())}/${path_relative_to_include()}" } },
  { env_tag = { "environment" : "${local.environment}" } },
)

