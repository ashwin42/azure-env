# Main terragrunt configuration file
# - Load and merge all variables from hcl files
# - Generate remote backend configuration
# - Generate all providers blocks
# - Generate merged inputs variables from all hcl files
#
# To add a new provider:
# - add a new provider.hcl.tftpl template file in terragrunt/providers/<provider_name>/ directory
# - add necessary default variables for the provider template in terragrunt/vars/default_vars.hcl (at least <provider_name>_provider_source and <provider_name>_provider_version)

# Skip terragrunt commands on this file
skip = true

locals {
  # Add providers to the list to generate proper provider blocks
  all_available_providers = [for f in fileset("./terragrunt/providers/", "*/provider.hcl.tftpl") : dirname(f)]

  # define all hcl config files, ordered by priority
  all_files = tolist([
    "global",
    "provider",
    "tenant",
    "enterprise",
    "organization",
    "site",
    "account",
    "environment",
    "region",
    "cluster",
    "server",
    "project",
    "general",
    "common",
    "local",
  ])

  # Load default variables
  default_vars = read_terragrunt_config("${get_repo_root()}/terragrunt/vars/default_vars.hcl")

  # Load variables from all_files
  vars = { for i in local.all_files : "${i}_vars" => try(
    read_terragrunt_config("${i}.hcl"),
    read_terragrunt_config(find_in_parent_folders("${i}.hcl")),
    {})
  }

  # Merge all gathered variables
  gathered_vars = merge(
    local.default_vars.locals,
    merge([for i in local.all_files : try(coalesce(local.vars["${i}_vars"].locals), {})]...)
  )

  # Adapt variables
  adapted_vars = {
    account_id  = try(coalesce(local.gathered_vars.aws_account_id), local.gathered_vars.account_id),
    aws_account = try(coalesce(local.gathered_vars.aws_account_id), local.gathered_vars.account_id),
    aws_region  = try(coalesce(local.gathered_vars.aws_region, local.gathered_vars.region), ""),
    aws_profile = try(coalesce(local.gathered_vars.aws_profile, local.gathered_vars.account_name != "default" ? "nv-${local.gathered_vars.account_name}" : ""), null)
    repo_path   = trimprefix(get_original_terragrunt_dir(), "${dirname(get_repo_root())}/")
    state_path  = trimprefix(get_original_terragrunt_dir(), "${get_repo_root()}/")
  }

  all_vars = merge(
    local.gathered_vars,
    local.adapted_vars,
  )

  # merge all tags
  all_tags = merge(
    local.default_vars.locals.tags,
    { "repo" : local.all_vars.repo_path },
    { "environment" : "${local.all_vars.environment}" },
    { "region" : coalesce("${local.all_vars.aws_region}", "global") },
    merge([for i in local.all_files : try(local.vars["${i}_vars"].locals.tags, {})]...)
  )

  # define default tags for aws provider
  default_tags = local.all_tags

  # backend settings
  # default settings for local backend
  local_state_enabled = try(coalesce(local.all_vars.local_state_enabled), false)
  local_state_path    = try(coalesce(local.all_vars.local_state_path), null)

  # default settings for s3 backend
  remote_state_s3_enabled                      = try(coalesce(local.all_vars.remote_state_s3_enabled), false)
  remote_state_s3_encrypt                      = try(coalesce(local.all_vars.remote_state_s3_encrypt), true)
  remote_state_s3_bucket                       = try(coalesce(local.all_vars.remote_state_s3_bucket), format("%s-%s", "nv-tf-state", "${local.all_vars.account_name != "default" ? local.all_vars.account_name : "undefined"}"))
  remote_state_s3_key_prefix                   = try(coalesce(local.all_vars.remote_state_s3_key_prefix), "infra")
  remote_state_s3_path                         = try(coalesce(local.all_vars.remote_state_s3_path), local.all_vars.state_path)
  remote_state_s3_region                       = try(coalesce(local.all_vars.remote_state_s3_region), "eu-north-1")
  remote_state_s3_dynamodb_table               = try(coalesce(local.all_vars.remote_state_s3_dynamodb_table), "terraform-locks")
  remote_state_s3_skip_region_validation       = try(coalesce(local.all_vars.remote_state_s3_skip_region_validation), true)
  remote_state_s3_bucket_tags                  = local.all_vars.remote_state_s3_bucket_tags
  remote_state_s3_bucket_tags_override         = local.all_vars.remote_state_s3_bucket_tags_override
  remote_state_s3_dynamodb_table_tags          = local.all_vars.remote_state_s3_bucket_tags
  remote_state_s3_dynamodb_table_tags_override = local.all_vars.remote_state_s3_bucket_tags_override

  # default settings for azurerm backend
  remote_state_azurerm_enabled              = try(coalesce(local.all_vars.remote_state_azurerm_enabled), false)
  remote_state_azurerm_storage_account_name = try(coalesce(local.all_vars.remote_state_azurerm_storage_account_name), "")
  remote_state_azurerm_container_name       = try(coalesce(local.all_vars.remote_state_azurerm_container_name), "")
  remote_state_azurerm_key                  = try(coalesce(local.all_vars.remote_state_azurerm_key), "${path_relative_to_include()}/terraform.tfstate")
  remote_state_azurerm_resource_group_name  = try(coalesce(local.all_vars.remote_state_azurerm_resource_group_name), "")
  remote_state_azurerm_subscription_id      = try(coalesce(local.all_vars.remote_state_azurerm_subscription_id), local.all_vars.azurerm_subscription_id)

  # generate local backend
  generate_local_state = local.local_state_enabled ? {
    backend = "local"
    generate = {
      path      = "tg_generated_backend.tf"
      if_exists = "overwrite"
    }

    config = {
      path = local.local_state_path
    }
  } : null

  # generate s3 backend
  generate_remote_state_s3 = local.remote_state_s3_enabled ? {
    backend = "s3"
    generate = {
      path      = "tg_generated_backend.tf"
      if_exists = "overwrite"
    }

    config = {
      encrypt                = tobool(local.remote_state_s3_encrypt)
      bucket                 = local.remote_state_s3_bucket
      key                    = "${local.remote_state_s3_key_prefix}/${local.remote_state_s3_path}/terraform.tfstate"
      region                 = local.remote_state_s3_region
      dynamodb_table         = local.remote_state_s3_dynamodb_table
      skip_region_validation = tobool(local.remote_state_s3_skip_region_validation)
      profile                = length(compact([local.all_vars.aws_profile])) > 0 ? local.all_vars.aws_profile : null
      role_arn               = length(compact([try(local.all_vars.remote_state_s3_role_arn, null)])) > 0 ? local.all_vars.remote_state_s3_role_arn : null
      s3_bucket_tags         = length(local.remote_state_s3_bucket_tags_override) > 0 ? local.remote_state_s3_bucket_tags_override : merge(local.all_tags, local.remote_state_s3_bucket_tags)
      dynamodb_table_tags    = length(local.remote_state_s3_dynamodb_table_tags_override) > 0 ? local.remote_state_s3_dynamodb_table_tags_override : merge(local.all_tags, local.remote_state_s3_dynamodb_table_tags)
    }
  } : null

  # generate azurerm backend
  generate_remote_state_azurerm = local.remote_state_azurerm_enabled ? {
    backend = "azurerm"
    generate = {
      path      = "tg_generated_backend.tf"
      if_exists = "overwrite"
    }

    config = {
      storage_account_name = local.remote_state_azurerm_storage_account_name
      container_name       = local.remote_state_azurerm_container_name
      key                  = local.remote_state_azurerm_key
      resource_group_name  = local.remote_state_azurerm_resource_group_name
      subscription_id      = local.remote_state_azurerm_subscription_id
    }
  } : null

  # generate terraform version
  generate_versions = local.all_vars.terraform_required_version != null ? {
    versions = {
      path      = "tg_generated_versions.tf"
      if_exists = "overwrite"
      contents  = <<EOF
terraform {
  required_version = "${local.all_vars.terraform_required_version}"
}
EOF
    }
  } : null

  all_providers = try(local.all_vars.providers_override, null) != null ? local.all_vars.providers_override : distinct(concat(
    try(coalesce(local.default_vars.locals.providers), []),
    flatten([for i in local.all_files : try(local.vars["${i}_vars"].locals.providers, [])])
    )
  )

  all_additional_providers = try(local.all_vars.additional_providers_override != null ? local.all_vars.additional_providers_override : tomap(false), merge(
    { for x in try(local.default_vars.locals.additional_providers, []) : x.alias => x },
    merge([for i in local.all_files : { for x in try(local.vars["${i}_vars"].locals.additional_providers, []) : x.alias => x }]...)
    )
  )

  all_delete_files = try(local.all_vars.delete_files_override, null) != null ? local.all_vars.delete_files_override : distinct(concat(
    try(local.default_vars.locals.delete_files, []),
    flatten([for i in local.all_files : try(local.vars["${i}_vars"].locals.delete_files, [])])
    )
  )

  # generate all providers
  generate_providers = {
    for provider in local.all_available_providers : provider => {
      "${provider}" = {
        path      = "tg_generated_provider_${provider}.tf"
        if_exists = "overwrite"
        contents = templatefile("./terragrunt/providers/${provider}/provider.hcl.tftpl", merge(
          {
            # generate all provider variables from all_vars
            # templates cannot use null values, so we need to convert them to empty strings
            for k, v in local.all_vars :
            k => v != null ? v : "" if can(tostring(v))
          },
          {
            # Add varaiables that are not strings
            for k, v in local.all_vars :
            k => v if !can(tostring(v))
          },
          {
            # Add special variables not in all_vars
            for k, v in {
              "default_tags" = local.default_tags
            } :
            k => v
          },
          )
        )
      }
    } if contains(local.all_providers, provider)
  }

  ## generate all providers version override
  generate_providers_version_override = {
    for provider in local.all_available_providers : provider => {
      "${provider}_override" = {
        path      = "tg_generated_provider_${provider}_override.tf"
        if_exists = "overwrite"
        contents = templatefile("./terragrunt/providers/version_override/override.hcl.tftpl", {
          version  = local.all_vars["${provider}_provider_version"]
          source   = local.all_vars["${provider}_provider_source"]
          provider = split("/", local.all_vars["${provider}_provider_source"])[1]
        })
      }
    } if contains(local.all_providers, provider) && can(coalesce(local.all_vars["${provider}_provider_version"]))
  }

  generate_additional_providers = {
    for provider in local.all_additional_providers :
    "${provider.provider}_${provider.alias}_provider" => {
      path      = "tg_generated_provider_${provider.provider}_${provider.alias}.tf"
      if_exists = "overwrite"
      contents  = <<-EOF
         provider "${provider.provider}" {
 %{for key, value in provider~}
 %{if key != "provider" && key != "blocks" && key != "raw"~}
           ${key} = "${value}"
 %{endif~}
 %{if key == "raw"~}
 %{for k, v in provider[key]~}
           ${k} = ${v}
 %{endfor~}
 %{endif~}
 %{if key == "blocks"~}
 %{for k, v in provider[key]~}
           ${k}  {
 %{for block_k, block_v in provider[key][k]~}
             ${block_k} = "${block_v}"
 %{endfor~}
           }
 %{endfor~}
 %{endif~}
 %{endfor~}
         }
         EOF
    }
  }

  # generate delete files
  generate_delete_files = { for file in toset(local.all_delete_files) :
    format("%s%s", "delete_", file) => {
      path      = file
      if_exists = "overwrite"
      contents  = ""
    }
  }

  # create a map of all providers to generate
  merge_generate_providers = merge([
    for provider in local.all_available_providers :
    local.generate_providers[provider] if contains(local.all_providers, provider)
  ]...)

  # create a map of all the versions overrides for providers to generate
  merge_generate_providers_version_override = merge([
    for provider in local.all_available_providers :
    local.generate_providers_version_override[provider] if
    contains(local.all_providers, provider) && length(compact([local.all_vars["${provider}_provider_version"]])) > 0
  ]...)

  generate = merge(
    local.generate_delete_files,
    local.merge_generate_providers,
    local.merge_generate_providers_version_override,
    try(length(compact([local.all_vars.terraform_required_version])) > 0 ? local.generate_versions : tomap(false), {}),
    try(length(local.generate_additional_providers) > 0 ? local.generate_additional_providers : tomap(false), {}),
    merge([for i in local.all_files : try(local.vars["${i}_vars"].generate, {})]...),
    {},
  )

  all_vars_keys = keys(merge(flatten(
    [for i in local.all_files : local.vars["${i}_vars"].locals if length(try(coalesce(local.vars["${i}_vars"].locals), {})) > 0]
  )...))

  final_vars = { for k, v in local.all_vars : k => v if v != null || contains(local.all_vars_keys, k) }

  final_tags = { tags = try(local.all_vars.tags_null, false) ? null : try(local.all_vars.tags_override != null ? local.all_vars.tags_override : tomap(false), local.all_tags) }
}

remote_state = merge(
  try(local.local_state_enabled ? local.generate_local_state : tomap(false), {}),
  try(local.remote_state_s3_enabled ? local.generate_remote_state_s3 : tomap(false), {}),
  try(local.remote_state_azurerm_enabled ? local.generate_remote_state_azurerm : tomap(false), {}),
  {},
)

generate = local.generate

terragrunt_version_constraint = local.all_vars.terragrunt_version_constraint
terraform_version_constraint  = try(coalesce(local.all_vars.terraform_version_constraint, local.all_vars.terraform_required_version), null)

inputs = merge(
  local.final_vars,
  local.final_tags
)

