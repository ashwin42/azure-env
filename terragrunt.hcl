locals {
  # Default variables, can be overridden by variables defined in each subsequent included hcl file
  default_vars = {
    azurerm_provider_version   = ""
    subscription_id            = ""
    location                   = ""
    terraform_required_version = ""
    product                    = ""
    environment                = ""
    azurerm_features           = ""
    tags                       = {}
  }

  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl", "account.hcl"), { locals = {}, generate = {} })

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl", "environment.hcl"), { locals = {}, generate = {} })

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl", "region.hcl"), { locals = {}, generate = {} })

  # Automatically load project-level variables
  project_vars = read_terragrunt_config(find_in_parent_folders("project.hcl", "project.hcl"), { locals = {}, generate = {} })

  # Automatically load local-level variables
  local_vars = read_terragrunt_config("local.hcl", { locals = {}, generate = {} })

  # Merge all variables
  all_vars = merge(local.default_vars, local.account_vars.locals, local.environment_vars.locals, local.region_vars.locals, local.project_vars.locals, local.local_vars.locals)

  # Extract the variables we need for easy access
  subscription_name = local.all_vars.subscription_name
  subscription_id   = local.all_vars.subscription_id
  location          = lookup(local.all_vars, "location", null) == null ? "" : local.all_vars.location
  environment       = local.all_vars.environment

  # Merge all tags
  all_tags = merge(lookup(local.default_vars, "tags", {}),
    try(lookup(local.account_vars.locals, "tags", {}), {}),
    try(lookup(local.environment_vars.locals, "tags", {}), {}),
    try(lookup(local.region_vars.locals, "tags", {}), {}),
    try(lookup(local.project_vars.locals, "tags", {}), {}),
    try(lookup(local.local_vars.locals, "tags", {}), {}))

}

# Delete existing provider.tf
generate "provider-delete" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = ""
}

# Generate an Azure provider block
generate "provider" {
  path      = "tg_generated_provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "${local.all_vars.azurerm_provider_version}"
    }
  }
}
provider "azurerm" {
  subscription_id = "${local.subscription_id}"
  ${local.all_vars.azurerm_features}
}
EOF
}

# Delete existing backend.tf
generate "backend-delete" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = ""
}

# Configure bucket
remote_state {
  backend = "azurerm"
  generate = {
    path      = "tg_generated_backend.tf"
    if_exists = "overwrite"
  }

  config = {
    storage_account_name = local.all_vars.remote_state_storage_account_name
    container_name       = local.all_vars.remote_state_container_name
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    resource_group_name  = local.all_vars.remote_state_resource_group_name
    subscription_id      = local.subscription_id
  }
}

# Delete existing versions.tf
generate "versions-delete" {
  path      = "versions.tf"
  if_exists = "overwrite"
  contents  = ""
}

# Configure versions
generate "versions" {
  path      = "tg_generated_versions.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_version = "${local.all_vars.terraform_required_version}"
}
EOF
}

generate = merge(local.account_vars.generate, local.environment_vars.generate, local.region_vars.generate, local.project_vars.generate, local.local_vars.generate)

inputs = merge(
  local.all_vars,
  { repo_tag = { "repo" : "${basename(get_parent_terragrunt_dir())}/${path_relative_to_include()}" } },
  { env_tag = { "environment" : "${local.environment}" } },
)

