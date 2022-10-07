locals {
  # default variables, can be overridden in each subsequent included hcl file
  default_vars = {
    # general
    terraform_required_version = null
    environment                = null
    tags                       = {}
    providers                  = []
    providers_override         = null
    delete_files               = []
    delete_files_override      = null
    # local backend
    local_state_enabled = null
    local_state_path    = "${get_terragrunt_dir()}/terraform.tfstate"
    # s3 backend
    remote_state_s3_enabled                = null
    remote_state_s3_bucket                 = null
    remote_state_s3_key_prefix             = null
    remote_state_s3_encrypt                = null
    remote_state_s3_bucket                 = null
    remote_state_s3_region                 = null
    remote_state_s3_dynamodb_table         = null
    remote_state_s3_skip_region_validation = null
    # azurerm backend
    remote_state_azurerm_enabled              = null
    remote_state_azurerm_storage_account_name = null
    remote_state_azurerm_container_name       = null
    remote_state_azurerm_key                  = null
    remote_state_azurerm_resource_group_name  = null
    remote_state_azurerm_subscription_id      = null
    #additional providers
    additional_providers = []
    # aws
    aws_provider_version = null
    aws_region           = null
    region               = null
    aws_profile          = null
    account_name         = null
    account_id           = null
    aws_account_id       = null
    allowed_account_ids  = []
    # azurerm
    azurerm_provider_version             = null
    azurerm_features                     = null
    azurerm_client_id                    = null
    azurerm_environment                  = null
    azurerm_subscription_id              = null
    azurerm_tenant_id                    = null
    azurerm_auxiliary_tenant_ids         = null
    azurerm_client_certificate_password  = null
    azurerm_client_certificate_path      = null
    azurerm_client_secret                = null
    azurerm_oidc_request_token           = null
    azurerm_oidc_request_url             = null
    azurerm_use_oidc                     = null
    azurerm_msi_endpoint                 = null
    azurerm_use_msi                      = null
    azurerm_disable_terraform_partner_id = null
    azurerm_metadata_host                = null
    azurerm_partner_id                   = null
    azurerm_skip_provider_registration   = null
    azurerm_storage_use_azuread          = null
    azurerm_use_msal                     = null
    # azuread
    azuread_provider_version             = null
    azuread_client_id                    = null
    azuread_environment                  = null
    azuread_tenant_id                    = null
    azuread_client_certificate           = null
    azuread_client_certificate_password  = null
    azuread_client_certificate_path      = null
    azuread_client_secret                = null
    azuread_oidc_request_token           = null
    azuread_oidc_request_url             = null
    azuread_use_oidc                     = null
    azuread_msi_endpoint                 = null
    azuread_use_msi                      = null
    azuread_use_cli                      = null
    azuread_disable_terraform_partner_id = null
    azuread_partner_id                   = null
    # guacamole
    guacamole_provider_version         = null
    guacamole_url                      = null
    guacamole_username                 = null
    guacamole_password                 = null
    guacamole_secret_name              = null
    guacamole_secret_name_key          = null
    guacamole_secret_store             = null
    guacamole_secret_path              = null
    guacamole_url                      = null
    guacamole_disable_tls_verification = null
    guacamole_disable_cookies          = null
    guacamole_secret_aws_profile       = null
    guacamole_secret_aws_region        = null
    # proxmox
    pm_provider_version   = null
    pm_provider_version   = null
    pm_api_url            = null
    pm_user               = null
    pm_password           = null
    pm_api_token_id       = null
    pm_api_token_secret   = null
    pm_otp                = null
    pm_tls_insecure       = true
    pm_parallel           = 4
    pm_log_enable         = false
    pm_log_levels         = {}
    pm_log_file           = null
    pm_timeout            = 30
    pm_debug              = false
    pm_proxy_server       = null
    target_node           = null
    pm_secret_name        = null
    pm_secret_name_key    = null
    pm_secret_store       = null
    pm_secret_path        = null
    pm_secret_aws_profile = null
    pm_secret_aws_region  = null
    # vsphere
    vsphere_provider_version      = null
    vsphere_secret_name           = null
    vsphere_secret_name_key       = null
    vsphere_secret_store          = null
    vsphere_secret_path           = null
    vsphere_server                = null
    vsphere_user                  = null
    vsphere_password              = null
    vsphere_allow_unverified_ssl  = null
    vsphere_vim_keep_alive        = null
    vsphere_api_timeout           = null
    vsphere_persist_session       = null
    vsphere_vim_session_path      = null
    vsphere_rest_session_path     = null
    vsphere_client_debug          = null
    vsphere_client_debug_path     = null
    vsphere_client_debug_path_run = null
    vsphere_secret_aws_profile    = null
    vsphere_secret_aws_region     = null
    # kubernetes_eks
    kubernetes_eks_provider_version = null
    kubernetes_eks_cluster_name     = null
    kubernetes_eks_api_version      = "client.authentication.k8s.io/v1alpha1"
    # helm_eks
    helm_eks_provider_version        = null
    helm_eks_kubernetes_cluster_name = null
    helm_eks_kubernetes_api_version  = "client.authentication.k8s.io/v1alpha1"
    # mysql
    mysql_provider_version   = null
    mysql_secret_aws_profile = null
    mysql_secret_aws_region  = null
    # postgresql
    postgresql_provider_version   = null
    postgresql_secret_aws_profile = null
    postgresql_secret_aws_region  = null
    # mssql
    mssql_provider_version = null
    # aci
    aci_provider_version   = null
    aci_secret_aws_profile = null
    aci_secret_aws_region  = null
    # mongodbatlas
    mongodbatlas_provider_version   = null
    mongodbatlas_secret_aws_profile = null
    mongodbatlas_secret_aws_region  = null
    # opsgenie
    opsgenie_provider_version   = null
    opsgenie_secret_aws_profile = null
    opsgenie_secret_aws_region  = null
    # github
    github_provider_version = null
    # grafana
    grafana_provider_version   = null
    grafana_secret_aws_profile = null
    grafana_secret_aws_region  = null
    # aviatrix
    aviatrix_provider_version   = null
    aviatrix_contoller_ip       = null
    aviatrix_secret_aws_profile = null
    aviatrix_secret_aws_region  = null
  }

  # load all hcl files
  global_vars      = read_terragrunt_config(find_in_parent_folders("global.hcl", "global.hcl"), { locals = {}, generate = {} })
  provider_vars    = read_terragrunt_config(find_in_parent_folders("provider.hcl", "provider.hcl"), { locals = {}, generate = {} })
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl", "account.hcl"), { locals = {}, generate = {} })
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl", "environment.hcl"), { locals = {}, generate = {} })
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl", "region.hcl"), { locals = {}, generate = {} })
  project_vars     = read_terragrunt_config(find_in_parent_folders("project.hcl", "project.hcl"), { locals = {}, generate = {} })
  general_vars     = read_terragrunt_config(find_in_parent_folders("general.hcl", "general.hcl"), { locals = {}, generate = {} })
  common_vars      = read_terragrunt_config(find_in_parent_folders("common.hcl", "common.hcl"), { locals = {}, generate = {} })
  local_vars       = read_terragrunt_config("local.hcl", { locals = {}, generate = {} })

  # merge all variables from loaded hcl files in specific order
  all_vars = merge(
    local.default_vars,
    local.global_vars.locals,
    local.provider_vars.locals,
    local.account_vars.locals,
    local.environment_vars.locals,
    local.region_vars.locals,
    local.project_vars.locals,
    local.general_vars.locals,
    local.common_vars.locals,
    local.local_vars.locals
  )

  # extract variables for direct access
  # general
  environment = local.all_vars.environment
  # aws
  account_name = local.all_vars.account_name
  account_id   = try(coalesce(local.all_vars.aws_account_id), local.all_vars.account_id)
  aws_account  = local.account_id
  aws_region   = try(coalesce(local.all_vars.aws_region, local.all_vars.region), "")
  aws_profile  = try(coalesce(local.all_vars.aws_profile, length(compact([local.all_vars.account_name])) > 0 ? "nv-${local.account_name}" : ""), null)

  # merge all tags
  all_tags = merge(
    try(lookup(local.default_vars, "tags", {}), {}),
    try(lookup(local.global_vars.locals, "tags", {}), {}),
    try(lookup(local.provider_vars.locals, "tags", {}), {}),
    try(lookup(local.account_vars.locals, "tags", {}), {}),
    try(lookup(local.environment_vars.locals, "tags", {}), {}),
    try(lookup(local.region_vars.locals, "tags", {}), {}),
    try(lookup(local.project_vars.locals, "tags", {}), {}),
    try(lookup(local.general_vars.locals, "tags", {}), {}),
    try(lookup(local.common_vars.locals, "tags", {}), {}),
    try(lookup(local.local_vars.locals, "tags", {}), {})
  )

  # define default tags for aws provider
  default_tags = merge(
    {
      environment = try(coalesce(local.environment), null)
      region      = coalesce("${local.aws_region}", "global")
      repo        = "${basename(get_parent_terragrunt_dir())}/${path_relative_to_include()}"
    },
    local.all_tags
  )

  # backend settings
  # default settings for local backend
  local_state_enabled = try(coalesce(local.all_vars.local_state_enabled), false)
  local_state_path    = try(coalesce(local.all_vars.local_state_path), null)

  # default settings for s3 backend
  remote_state_s3_enabled                = try(coalesce(local.all_vars.remote_state_s3_enabled), false)
  remote_state_s3_encrypt                = try(coalesce(local.all_vars.remote_state_s3_encrypt), true)
  remote_state_s3_bucket                 = try(coalesce(local.all_vars.remote_state_s3_bucket), format("%s-%s", "nv-tf-state", "${length(compact([local.account_name])) > 0 ? local.account_name : "undefined"}"))
  remote_state_s3_key_prefix             = try(coalesce(local.all_vars.remote_state_s3_key_prefix), "infra")
  remote_state_s3_region                 = try(coalesce(local.all_vars.remote_state_s3_region), "eu-north-1")
  remote_state_s3_dynamodb_table         = try(coalesce(local.all_vars.remote_state_s3_dynamodb_table), "terraform-locks")
  remote_state_s3_skip_region_validation = try(coalesce(local.all_vars.remote_state_s3_skip_region_validation), true)

  # default settings for azurerm backend
  remote_state_azurerm_enabled              = try(coalesce(local.all_vars.remote_state_azurerm_enabled), false)
  remote_state_azurerm_storage_account_name = try(coalesce(local.all_vars.remote_state_azurerm_storage_account_name), "")
  remote_state_azurerm_container_name       = try(coalesce(local.all_vars.remote_state_azurerm_container_name), "")
  remote_state_azurerm_key                  = try(coalesce(local.all_vars.remote_state_azurerm_key), "${path_relative_to_include()}/terraform.tfstate")
  remote_state_azurerm_resource_group_name  = try(coalesce(local.all_vars.remote_state_azurerm_resource_group_name), "")
  remote_state_azurerm_subscription_id      = try(coalesce(local.all_vars.remote_state_azurerm_subscription_id), local.all_vars.azurerm_subscription_id)

  # generate local backend
  generate_local_state = {
    backend = "local"
    generate = {
      path      = "tg_generated_backend.tf"
      if_exists = "overwrite"
    }

    config = {
      path = local.local_state_path
    }
  }

  # generate s3 backend
  generate_remote_state_s3 = {
    backend = "s3"
    generate = {
      path      = "tg_generated_backend.tf"
      if_exists = "overwrite"
    }

    config = {
      encrypt                = tobool(local.remote_state_s3_encrypt)
      bucket                 = local.remote_state_s3_bucket
      key                    = "${local.remote_state_s3_key_prefix}/${path_relative_to_include()}/terraform.tfstate"
      region                 = local.remote_state_s3_region
      dynamodb_table         = local.remote_state_s3_dynamodb_table
      skip_region_validation = tobool(local.remote_state_s3_skip_region_validation)
      profile                = length(compact([local.aws_profile])) > 0 ? local.aws_profile : null
    }
  }

  # generate azurerm backend
  generate_remote_state_azurerm = {
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
  }

  # generate terraform version
  generate_versions = {
    versions = {
      path      = "tg_generated_versions.tf"
      if_exists = "overwrite"
      contents  = <<EOF
terraform {
  required_version = "${try(coalesce(local.all_vars.terraform_required_version), "")}"
}
EOF
    }
  }

  # generate aws provider
  generate_aws_provider = {
    aws_provider = {
      path      = "tg_generated_provider_aws.tf"
      if_exists = "overwrite"
      contents  = <<EOF
variable "allowed_account_ids" {
  type    = list(string)
  default = []
}

variable "aws_profile" {
  type    = string
  default = null
}

locals {
  allowed_account_ids = distinct(concat(var.allowed_account_ids, ["${try(coalesce(local.account_id), "")}"]))
}

provider "aws" {
  region              = "${coalesce(local.aws_region, "eu-north-1")}"
  allowed_account_ids = local.allowed_account_ids
%{if length(compact([local.aws_profile])) > 0~}
  profile             = "${local.aws_profile}"
%{endif~}
  default_tags {
    tags = {
%{for key, value in local.default_tags}
%{~if length(compact([value])) > 0~}
      ${key} = "${value}"
%{endif~}
%{endfor~}
    }
  }
}
EOF
    }
  }

  generate_aws_provider_override = {
    aws_provider_override = {
      path      = "tg_generated_provider_aws_override.tf"
      if_exists = "overwrite"
      contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "${try(coalesce(local.all_vars.aws_provider_version), "")}"
    }
  }
}
EOF
    }
  }

  # generate azurerm provider
  generate_azurerm_provider = {
    azurerm_provider = {
      path      = "tg_generated_provider_azurerm.tf"
      if_exists = "overwrite"
      contents  = <<EOF
variable "azurerm_features" {
  type    = map(string)
  default = {}
}

variable "azurerm_client_id" {
  type    = string
  default = null
}

variable "azurerm_environment" {
  type    = string
  default = null
}

variable "azurerm_subscription_id" {
  type    = string
  default = null
}

variable "azurerm_tenant_id" {
  type    = string
  default = null
}

variable "azurerm_auxiliary_tenant_ids" {
  type    = list(string)
  default = []
}

variable "azurerm_client_certificate_password" {
  type    = string
  default = null
}

variable "azurerm_client_certificate_path" {
  type    = string
  default = null
}

variable "azurerm_client_secret" {
  type    = string
  default = null
}

variable "azurerm_oidc_request_token" {
  type    = string
  default = null
}

variable "azurerm_oidc_request_url" {
  type    = string
  default = null
}

variable "azurerm_use_oidc" {
  type    = bool
  default = null
}

variable "azurerm_msi_endpoint" {
  type    = string
  default = null
}

variable "azurerm_use_msi" {
  type    = bool
  default = null
}

variable "azurerm_disable_terraform_partner_id" {
  type    = bool
  default = null
}

variable "azurerm_metadata_host" {
  type    = string
  default = null
}

variable "azurerm_partner_id" {
  type    = string
  default = null
}

variable "azurerm_skip_provider_registration" {
  type    = bool
  default = null
}

variable "azurerm_storage_use_azuread" {
  type    = bool
  default = null
}

variable "azurerm_use_msal" {
  type    = bool
  default = null
}

provider "azurerm" {
  subscription_id              = try(coalesce(var.azurerm_subscription_id), null)
  client_id                    = try(coalesce(var.azurerm_client_id), null)
  environment                  = try(coalesce(var.azurerm_environment), null)
  tenant_id                    = try(coalesce(var.azurerm_tenant_id), null)
  client_certificate_password  = try(coalesce(var.azurerm_client_certificate_password), null)
  client_certificate_path      = try(coalesce(var.azurerm_client_certificate_path), null)
  client_secret                = try(coalesce(var.azurerm_client_secret), null)
  msi_endpoint                 = try(coalesce(var.azurerm_msi_endpoint), null)
  use_msi                      = try(coalesce(var.azurerm_use_msi), null)
  partner_id                   = try(coalesce(var.azurerm_partner_id), null)
  auxiliary_tenant_ids         = try(coalesce(var.azurerm_auxiliary_tenant_ids), null)
  skip_provider_registration   = try(coalesce(var.azurerm_skip_provider_registration), null)
%{~if try(coalesce(local.all_vars.azurerm_features), null) != null}
  features {
%{~for key, value in local.all_vars.azurerm_features}
    ${key} {
%{~for k, v in value}
      ${k} = ${v~}
%{endfor}
    }
%{endfor~}
  }
%{endif}
%{~if try(coalesce(local.all_vars.azurerm_disable_terraform_partner_id), null) != null}
  disable_terraform_partner_id = try(coalesce(var.azurerm_disable_terraform_partner_id), null)
%{endif}
%{~if try(coalesce(local.all_vars.azurerm_oidc_request_token), null) != null}
  oidc_request_token           = try(coalesce(var.azurerm_oidc_request_token), null)
%{endif}
%{~if try(coalesce(local.all_vars.azurerm_oidc_request_url), null) != null}
  oidc_request_url             = try(coalesce(var.azurerm_oidc_request_url), null)
%{endif}
%{~if try(coalesce(local.all_vars.azurerm_use_oidc), null) != null}
  use_oidc                     = try(coalesce(var.azurerm_use_oidc), null)
%{endif}
%{~if try(coalesce(local.all_vars.azurerm_metadata_host), null) != null}
  metadata_host                = try(coalesce(var.azurerm_metadata_host), null)
%{endif}
%{~if try(coalesce(local.all_vars.azurerm_storage_use_azuread), null) != null}
  storage_use_azuread          = try(coalesce(var.azurerm_storage_use_azuread), null)
%{endif}
}
EOF
    }
  }

  generate_azurerm_provider_override = {
    azurerm_provider_override = {
      path      = "tg_generated_provider_azurerm_override.tf"
      if_exists = "overwrite"
      contents  = <<EOF
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "${try(coalesce(local.all_vars.azurerm_provider_version), "")}"
    }
  }
}
EOF
    }
  }

  # generate azuread provider
  generate_azuread_provider = {
    azuread_provider = {
      path      = "tg_generated_provider_azuread.tf"
      if_exists = "overwrite"
      contents  = <<EOF
variable "azuread_client_id" {
  type    = string
  default = null
}
variable "azuread_environment" {
  type    = string
  default = null
}
variable "azuread_tenant_id" {
  type    = string
  default = null
}
variable "azuread_client_certificate" {
  type    = string
  default = null
}
variable "azuread_client_certificate_password" {
  type    = string
  default = null
}
variable "azuread_client_certificate_path" {
  type    = string
  default = null
}
variable "azuread_client_secret" {
  type    = string
  default = null
}
variable "azuread_oidc_request_token" {
  type    = string
  default = null
}
variable "azuread_oidc_request_url" {
  type    = string
  default = null
}
variable "azuread_use_oidc" {
  type    = string
  default = null
}
variable "azuread_msi_endpoint" {
  type    = string
  default = null
}
variable "azuread_use_msi" {
  type    = string
  default = null
}
variable "azuread_use_cli" {
  type    = string
  default = null
}
variable "azuread_disable_terraform_partner_id" {
  type    = string
  default = null
}
variable "azuread_partner_id" {
  type    = string
  default = null
}

provider "azuread" {
  client_id                    = try(coalesce(var.azuread_client_id), null)
  environment                  = try(coalesce(var.azuread_environment), null)
  tenant_id                    = try(coalesce(var.azuread_tenant_id), null)
  client_certificate_password  = try(coalesce(var.azuread_client_certificate_password), null)
  client_certificate_path      = try(coalesce(var.azuread_client_certificate_path), null)
  client_secret                = try(coalesce(var.azuread_client_secret), null)
  msi_endpoint                 = try(coalesce(var.azuread_msi_endpoint), null)
  use_msi                      = try(coalesce(var.azuread_use_msi), null)
  disable_terraform_partner_id = try(coalesce(var.azuread_disable_terraform_partner_id), null)
  partner_id                   = try(coalesce(var.azuread_partner_id), null)
%{~if try(coalesce(local.all_vars.azuread_client_certificate), null) != null}
  client_certificate           = try(coalesce(var.azuread_client_certificate), null)
%{endif}
%{~if try(coalesce(local.all_vars.azuread_oidc_request_token), null) != null}
  oidc_request_token           = try(coalesce(var.azuread_oidc_request_token), null)
%{endif}
%{~if try(coalesce(local.all_vars.azuread_oidc_request_url), null) != null}
  oidc_request_url             = try(coalesce(var.azuread_oidc_request_url), null)
%{endif}
%{~if try(coalesce(local.all_vars.azuread_use_oidc), null) != null}
  use_oidc                     = try(coalesce(var.azuread_use_oidc), null)
%{endif}
%{~if try(coalesce(local.all_vars.azuread_use_cli), null) != null}
  use_cli                      = try(coalesce(var.azuread_use_cli), null)
%{endif}
}
EOF
    }
  }

  generate_azuread_provider_override = {
    azuread_provider_override = {
      path      = "tg_generated_provider_azuread_override.tf"
      if_exists = "overwrite"
      contents  = <<EOF
terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "${try(coalesce(local.all_vars.azuread_provider_version), "")}"
    }
  }
}
EOF
    }
  }

  # generate guacamole provider
  generate_guacamole_provider = {
    guacamole_provider = {
      path      = "tg_generated_provider_guacamole.tf"
      if_exists = "overwrite"
      contents  = <<EOF
variable "guacamole_url" {
  type = string
}

variable "guacamole_username" {
  type = string
}

variable "guacamole_password" {
  type    = string
  default = null
}

variable "guacamole_disable_tls_verification" {
  type    = bool
  default = null
}

variable "guacamole_disable_cookies" {
  type    = bool
  default = null
}

variable "guacamole_secret_name" {
  type    = string
  default = null
}

variable "guacamole_secret_name_key" {
  type    = string
  default = null
}

variable "guacamole_secret_store" {
  type    = string
  default = null
}

variable "guacamole_secret_path" {
  type    = string
  default = null
}

locals {
  guacamole_hostname = replace(var.guacamole_url, "/(https?://)|(/)/", "")
}

module "guacamole_provider_secret" {
  count           = length(compact([var.guacamole_password])) > 0 ? 0 : 1
  source          = "github.com/northvolt/tf-mod-common//secrets?ref=v2.2.0"
  secret_name     = try(coalesce(var.guacamole_secret_name), local.guacamole_hostname)
  secret_name_key = try(coalesce(var.guacamole_secret_name_key), var.guacamole_username)
  secret_path     = try(coalesce(var.guacamole_secret_path), null)
  store           = try(coalesce(var.guacamole_secret_store), "secrets-manager")
%{if local.all_vars.guacamole_secret_aws_profile != null~}
  providers = {
    aws = aws.guacamole_secret
  }
%{endif~}
}

provider "guacamole" {
  url                      = try(coalesce(var.guacamole_url), null)
  username                 = coalesce(var.guacamole_username, "guacadmin")
  password                 = try(coalesce(var.guacamole_password), module.guacamole_provider_secret[0].secret)
  disable_tls_verification = try(coalesce(var.guacamole_disable_tls_verification), false)
  disable_cookies          = try(coalesce(var.guacamole_disable_cookies), false)
}

%{if local.all_vars.guacamole_secret_aws_profile != null~}
provider "aws" {
  region  = "${coalesce(local.all_vars.guacamole_secret_aws_region, local.aws_region, "eu-north-1")}"
  profile = "${local.all_vars.guacamole_secret_aws_profile}"
  alias   = "guacamole_secret"
}
%{endif~}
EOF
    }
  }

  generate_guacamole_provider_override = {
    guacamole_provider_override = {
      path      = "tg_generated_provider_guacamole_override.tf"
      if_exists = "overwrite"
      contents  = <<EOF
terraform {
  required_providers {
    guacamole = {
      source  = "techBeck03/guacamole"
      version = "${try(coalesce(local.all_vars.guacamole_provider_version), "")}"
    }
  }
}
EOF
    }
  }

  # generate proxmox provider
  generate_proxmox_provider = {
    proxmox_provider = {
      path      = "tg_generated_provider_proxmox.tf"
      if_exists = "overwrite"
      contents  = <<EOF
locals {
  proxmox_hostname = replace(var.pm_api_url, "/(https?://)|(/)|(:.*)/", "")
}

variable "pm_secret_name" {
  type    = string
  default = null
}

variable "pm_secret_name_key" {
  type    = string
  default = null
}

variable "pm_secret_store" {
  type    = string
  default = null
}

variable "pm_secret_path" {
  type    = string
  default = null
}

variable "pm_api_url" {
  type    = string
}

variable "pm_user" {
  type    = string
  default = null
}

variable "pm_password" {
  type    = string
  default = null
}

variable "pm_api_token_id" {
  type    = string
  default = null
}

variable "pm_api_token_secret" {
  type    = string
  default = null
}

variable "pm_otp" {
  type    = string
  default = null
}

variable "pm_tls_insecure" {
  type    = string
  default = null
}

variable "pm_parallel" {
  type    = string
  default = null
}

variable "pm_log_enable" {
  type    = string
  default = null
}

variable "pm_log_levels" {
  type = map(any)
  default = {}
}

variable "pm_log_file" {
  type    = string
  default = null
}

variable "pm_timeout" {
  type    = string
  default = null
}

variable "pm_debug" {
  type    = string
  default = null
}

variable "pm_proxy_server" {
  type    = string
  default = null
}

module "proxmox_provider_secret" {
  for_each = toset(compact([
    length(compact([var.pm_user])) > 0 ? "" : "pm_user",
    length(compact([var.pm_password])) > 0 ? "" : "pm_password",
    length(compact([var.pm_api_token_id])) > 0 ? "" : "pm_api_token_id",
    length(compact([var.pm_api_token_secret])) > 0 ? "" : "pm_api_token_secret"
  ]))
  source          = "github.com/northvolt/tf-mod-common//secrets?ref=v2.2.0"
  secret_name     = try(coalesce(var.pm_secret_name), local.proxmox_hostname)
  secret_name_key = each.value
  secret_path     = try(coalesce(var.pm_secret_path), null)
  store           = try(coalesce(var.pm_secret_store), "secrets-manager")
%{if local.all_vars.pm_secret_aws_profile != null~}
  providers = {
    aws = aws.pm_secret
  }
%{endif~}
}

provider "proxmox" {
  pm_api_url          = var.pm_api_url
  pm_user             = length(compact([var.pm_user])) > 0 ? var.pm_user : module.proxmox_provider_secret["pm_user"].secret
  pm_password         = length(compact([var.pm_password])) > 0 ? var.pm_password : module.proxmox_provider_secret["pm_password"].secret
  pm_api_token_id     = length(compact([var.pm_api_token_id])) > 0 ? var.pm_api_token_id : module.proxmox_provider_secret["pm_api_token_id"].secret
  pm_api_token_secret = length(compact([var.pm_api_token_secret])) > 0 ? var.pm_api_token_secret : module.proxmox_provider_secret["pm_api_token_secret"].secret
  pm_otp              = var.pm_otp
  pm_tls_insecure     = var.pm_tls_insecure
  pm_parallel         = var.pm_parallel
  pm_log_enable       = var.pm_log_enable
  pm_log_levels       = var.pm_log_levels
  pm_log_file         = var.pm_log_file
  pm_timeout          = var.pm_timeout
  pm_debug            = var.pm_debug
  pm_proxy_server     = var.pm_proxy_server

%{if local.all_vars.pm_secret_aws_profile != null~}
provider "aws" {
  region  = "${coalesce(local.all_vars.pm_secret_aws_region, local.aws_region, "eu-north-1")}"
  profile = "${local.all_vars.pm_secret_aws_profile}"
  alias   = "pm_secret"
}
%{endif~}
}
EOF
    }
  }

  generate_proxmox_provider_override = {
    proxmox_provider_override = {
      path      = "tg_generated_provider_proxmox_override.tf"
      if_exists = "overwrite"
      contents  = <<EOF
terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "${try(coalesce(local.all_vars.pm_provider_version), "")}"
    }
  }
}
EOF
    }
  }

  # generate vsphere provider
  generate_vsphere_provider = {
    vsphere_provider = {
      path      = "tg_generated_provider_vsphere.tf"
      if_exists = "overwrite"
      contents  = <<EOF
variable "vsphere_secret_name" {
  type    = string
  default = null
}

variable "vsphere_secret_name_key" {
  type    = string
  default = null
}

variable "vsphere_secret_store" {
  type    = string
  default = null
}

variable "vsphere_secret_path" {
  type    = string
  default = null
}

variable "vsphere_server" {
  type    = string
  default = null
}

variable "vsphere_user" {
  type    = string
  default = null
}

variable "vsphere_password" {
  type    = string
  default = null
}

variable "vsphere_allow_unverified_ssl" {
  type    = bool
  default = null
}

variable "vsphere_vim_keep_alive" {
  type    = number
  default = null
}

variable "vsphere_api_timeout" {
  type    = number
  default = null
}

variable "vsphere_persist_session" {
  type    = bool
  default = null
}

variable "vsphere_vim_session_path" {
  type    = string
  default = null
}

variable "vsphere_rest_session_path" {
  type    = string
  default = null
}

variable "vsphere_client_debug" {
  type    = bool
  default = null
}

variable "vsphere_client_debug_path" {
  type    = string
  default = null
}

variable "vsphere_client_debug_path_run" {
  type    = string
  default = null
}

module "vsphere_provider_secret" {
  count           = length(compact([var.vsphere_password])) > 0 ? 0 : 1
  source          = "github.com/northvolt/tf-mod-common//secrets?ref=v2.2.0"
  secret_name     = try(coalesce(var.vsphere_secret_name), var.vsphere_server)
  secret_name_key = try(coalesce(var.vsphere_secret_name_key), var.vsphere_user)
  secret_path     = try(coalesce(var.vsphere_secret_path), null)
  store           = try(coalesce(var.vsphere_secret_store), "secrets-manager")
%{if local.all_vars.vsphere_secret_aws_profile != null~}
  providers = {
    aws = aws.vsphere_secret
  }
%{endif~}
}

provider "vsphere" {
  user                  = var.vsphere_user
  password              = try(coalesce(var.vsphere_password), module.vsphere_provider_secret[0].secret)
  vsphere_server        = var.vsphere_server
  allow_unverified_ssl  = try(coalesce(var.vsphere_allow_unverified_ssl), null)
  vim_keep_alive        = try(coalesce(var.vsphere_vim_keep_alive), null)
  api_timeout           = try(coalesce(var.vsphere_api_timeout), null)
  persist_session       = try(coalesce(var.vsphere_persist_session), null)
  vim_session_path      = try(coalesce(var.vsphere_vim_session_path), null)
  rest_session_path     = try(coalesce(var.vsphere_rest_session_path), null)
  client_debug          = try(coalesce(var.vsphere_client_debug), null)
  client_debug_path     = try(coalesce(var.vsphere_client_debug_path), null)
  client_debug_path_run = try(coalesce(var.vsphere_client_debug_path_run), null)
}

%{if local.all_vars.vsphere_secret_aws_profile != null~}
provider "aws" {
  region  = "${coalesce(local.all_vars.vsphere_secret_aws_region, local.aws_region, "eu-north-1")}"
  profile = "${local.all_vars.vsphere_secret_aws_profile}"
  alias   = "vsphere_secret"
}
%{endif~}
EOF
    }
  }

  generate_vsphere_provider_override = {
    vsphere_provider_override = {
      path      = "tg_generated_provider_vsphere_override.tf"
      if_exists = "overwrite"
      contents  = <<EOF
terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = "${try(coalesce(local.all_vars.vsphere_provider_version), "")}"
    }
  }
}
EOF
    }
  }

  # generate kubernetes provider for EKS
  generate_kubernetes_eks_provider = {
    kubernetes_eks_provider = {
      path      = "tg_generated_provider_kubernetes_eks.tf"
      if_exists = "overwrite"
      contents  = <<EOF
variable "kubernetes_eks_cluster_name" {
  type    = string
  default = null
}

data "aws_eks_cluster" "kubernetes_eks" {
  name = var.kubernetes_eks_cluster_name
}

provider "kubernetes" {
    host                   = data.aws_eks_cluster.kubernetes_eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.kubernetes_eks.certificate_authority.0.data)

    exec {
      api_version = "${local.all_vars.kubernetes_eks_api_version}"
      command     = "aws"
%{if length(compact([local.aws_profile])) > 0~}
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.kubernetes_eks.name, "--no-cli-auto-prompt", "--profile", "${local.aws_profile}"]
%{else~}
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.kubernetes_eks.name, "--no-cli-auto-prompt"]
%{endif}
    }
}
EOF
    }
  }

  generate_kubernetes_eks_provider_override = {
    kubernetes_eks_provider_override = {
      path      = "tg_generated_provider_kubernetes_eks_override.tf"
      if_exists = "overwrite"
      contents  = <<EOF
terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "${try(coalesce(local.all_vars.kubernetes_eks_provider_version), "")}"
    }
  }
}
EOF
    }
  }

  # generate helm provider
  generate_helm_eks_provider = {
    helm_eks_provider = {
      path      = "tg_generated_provider_helm_eks.tf"
      if_exists = "overwrite"
      contents  = <<EOF
variable "helm_eks_kubernetes_cluster_name" {
  type    = string
  default = null
}

data "aws_eks_cluster" "helm_eks" {
  name = var.helm_eks_kubernetes_cluster_name
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.helm_eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.helm_eks.certificate_authority.0.data)

    exec {
      api_version = "${local.all_vars.helm_eks_kubernetes_api_version}"
      command     = "aws"
%{if length(compact([local.aws_profile])) > 0~}
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.kubernetes_eks.name, "--no-cli-auto-prompt", "--profile", "${local.aws_profile}"]
%{else~}
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.kubernetes_eks.name, "--no-cli-auto-prompt"]
%{endif}
    }
  }
}
EOF
    }
  }

  generate_helm_eks_provider_override = {
    helm_eks_provider_override = {
      path      = "tg_generated_provider_helm_eks_override.tf"
      if_exists = "overwrite"
      contents  = <<EOF
terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "${try(coalesce(local.all_vars.helm_eks_provider_version), "")}"
    }
  }
}
EOF
    }
  }

  # generate mysql provider
  generate_mysql_provider = {
    mysql_provider = {
      path      = "tg_generated_provider_mysql.tf"
      if_exists = "overwrite"
      contents  = <<EOF
variable "mysql_secret_name" {
  type    = string
  default = null
}

variable "mysql_secret_name_key" {
  type    = string
  default = null
}

variable "mysql_secret_store" {
  type    = string
  default = null
}

variable "mysql_secret_path" {
  type    = string
  default = null
}

variable "mysql_master_username" {
  type    = string
  default = null
}

variable "mysql_master_password" {
  type    = string
  default = null
}

variable "mysql_endpoint" {
  type    = string
  default = null
}

variable "mysql_proxy" {
  type    = string
  default = null
}

variable "mysql_tls" {
  type    = bool
  default = false
}

variable "mysql_max_conn_lifetime_sec" {
  type    = number
  default = null
}

variable "mysql_max_open_conns" {
  type    = number
  default = null
}

variable "mysql_conn_params" {
  type    = string
  default = null
}

variable "mysql_authentication_plugin" {
  type    = string
  default = null
}

variable "mysql_connect_retry_timeout_sec" {
  type    = number
  default = 30
}

module "mysql_provider_secret" {
  count           = length(compact([var.mysql_master_password])) > 0 ? 0 : 1
  source          = "github.com/northvolt/tf-mod-common//secrets?ref=v2.2.0"
  secret_name     = try(coalesce(var.mysql_secret_name), var.mysql_endpoint)
  secret_name_key = try(coalesce(var.mysql_secret_name_key), var.mysql_master_username)
  secret_path     = try(coalesce(var.mysql_secret_path), null)
  store           = try(coalesce(var.mysql_secret_store), "secrets-manager")
%{if local.all_vars.mysql_secret_aws_profile != null~}
  providers = {
    aws = aws.mysql_secret
  }
%{endif~}
}

provider "mysql" {
  endpoint                  = var.mysql_endpoint
  username                  = var.mysql_master_username
  password                  = try(coalesce(var.mysql_master_password), module.mysql_provider_secret[0].secret)
  proxy                     = try(coalesce(var.mysql_proxy), null)
  tls                       = try(coalesce(var.mysql_tls), null)
  max_conn_lifetime_sec     = try(coalesce(var.mysql_max_conn_lifetime_sec), null)
  max_open_conns            = try(coalesce(var.mysql_max_open_conns), null)
  conn_params               = try(coalesce(var.mysql_conn_params), null)
  authentication_plugin     = try(coalesce(var.mysql_authentication_plugin), null)
  connect_retry_timeout_sec = try(coalesce(var.mysql_connect_retry_timeout_sec), null)
}

%{if local.all_vars.mysql_secret_aws_profile != null~}
provider "aws" {
  region  = "${coalesce(local.all_vars.mysql_secret_aws_region, local.aws_region, "eu-north-1")}"
  profile = "${local.all_vars.mysql_secret_aws_profile}"
  alias   = "mysql_secret"
}
%{endif~}
EOF
    }
  }

  generate_mysql_provider_override = {
    mysql_provider_override = {
      path      = "tg_generated_provider_mysql_override.tf"
      if_exists = "overwrite"
      contents  = <<EOF
terraform {
  required_providers {
    mysql = {
      source  = "petoju/mysql"
      version = "${try(coalesce(local.all_vars.mysql_provider_version), "")}"
    }
  }
}
EOF
    }
  }

  # generate postgresql provider
  generate_postgresql_provider = {
    postgresql_provider = {
      path      = "tg_generated_provider_postgresql.tf"
      if_exists = "overwrite"
      contents  = <<EOF
variable "postgresql_secret_name" {
  type    = string
  default = null
}

variable "postgresql_secret_name_key" {
  type    = string
  default = null
}

variable "postgresql_secret_store" {
  type    = string
  default = null
}

variable "postgresql_secret_path" {
  type    = string
  default = null
}

variable "postgresql_scheme" {
  type    = string
  default = "awspostgres"
}

variable "postgresql_host" {
  type    = string
  default = null
}

variable "postgresql_port" {
  type    = string
  default = null
}

variable "postgresql_database" {
  type    = string
  default = null
}

variable "postgresql_username" {
  type    = string
  default = null
}

variable "postgresql_password" {
  type    = string
  default = null
}

variable "postgresql_database_username" {
  type    = string
  default = null
}

variable "postgresql_superuser" {
  type    = bool
  default = false
}

variable "postgresql_sslmode" {
  type    = string
  default = null
}

variable "postgresql_clientcert" {
  type    = map(string)
  default = {}
}

variable "postgresql_sslrootcert" {
  type    = string
  default = null
}

variable "postgresql_connect_timeout" {
  type    = number
  default = null
}

variable "postgresql_max_connections" {
  type    = number
  default = null
}

variable "postgresql_expected_version" {
  type    = string
  default = null
}

module "postgresql_provider_secret" {
  count           = length(compact([var.postgresql_password])) > 0 ? 0 : 1
  source          = "github.com/northvolt/tf-mod-common//secrets?ref=v2.2.0"
  secret_name     = try(coalesce(var.postgresql_secret_name), var.postgresql_host)
  secret_name_key = try(coalesce(var.postgresql_secret_name_key), var.postgresql_username)
  secret_path     = try(coalesce(var.postgresql_secret_path), null)
  store           = try(coalesce(var.postgresql_secret_store), "secrets-manager")
%{if local.all_vars.postgresql_secret_aws_profile != null~}
  providers = {
    aws = aws.postgresql_secret
  }
%{endif~}
}

provider "postgresql" {
  scheme            = try(coalesce(var.postgresql_scheme), null)
  host              = try(coalesce(var.postgresql_host), null)
  port              = try(coalesce(var.postgresql_port), null)
  database          = try(coalesce(var.postgresql_database), null)
  username          = try(coalesce(var.postgresql_username), null)
  password          = try(coalesce(var.postgresql_password), module.postgresql_provider_secret[0].secret)
  database_username = try(coalesce(var.postgresql_database_username), null)
  superuser         = try(coalesce(var.postgresql_superuser), null)
  sslmode           = try(coalesce(var.postgresql_sslmode), null)
  dynamic "clientcert" {
    for_each = length(var.postgresql_clientcert) > 0 ? [var.postgresql_clientcert] : []
    content {
      cert = try(coalesce(clientcert.cert), null) != null
      key  = try(coalesce(clientcert.key), null) != null
    }
  }
  sslrootcert      = try(coalesce(var.postgresql_sslrootcert), null)
  connect_timeout  = try(coalesce(var.postgresql_connect_timeout), null)
  max_connections  = try(coalesce(var.postgresql_max_connections), null)
  expected_version = try(coalesce(var.postgresql_expected_version), null)
}

%{if local.all_vars.postgresql_secret_aws_profile != null~}
provider "aws" {
  region  = "${coalesce(local.all_vars.postgresql_secret_aws_region, local.aws_region, "eu-north-1")}"
  profile = "${local.all_vars.postgresql_secret_aws_profile}"
  alias   = "postgresql_secret"
}
%{endif~}
EOF
    }
  }

  generate_postgresql_provider_override = {
    postgresql_provider_override = {
      path      = "tg_generated_provider_postgresql_override.tf"
      if_exists = "overwrite"
      contents  = <<EOF
terraform {
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "${try(coalesce(local.all_vars.postgresql_provider_version), "")}"
    }
  }
}
EOF
    }
  }

  # generate mssql provider
  generate_mssql_provider = {
    mssql_provider = {
      path      = "tg_generated_provider_mssql.tf"
      if_exists = "overwrite"
      contents  = <<EOF
provider "mssql" {
}
EOF
    }
  }

  generate_mssql_provider_override = {
    mssql_provider_override = {
      path      = "tg_generated_provider_mssql_override.tf"
      if_exists = "overwrite"
      contents  = <<EOF
terraform {
  required_providers {
    mssql = {
      source  = "betr-io/mssql"
      version = "${try(coalesce(local.all_vars.mssql_provider_version), "")}"
    }
  }
}
EOF
    }
  }

  # generate aci provider
  generate_aci_provider = {
    aci_provider = {
      path      = "tg_generated_provider_aci.tf"
      if_exists = "overwrite"
      contents  = <<EOF
variable "aci_secret_name" {
  type    = string
  default = null
}

variable "aci_secret_name_key" {
  type    = string
  default = null
}

variable "aci_secret_store" {
  type    = string
  default = null
}

variable "aci_secret_path" {
  type    = string
  default = null
}

variable "aci_username" {
  type    = string
  default = null
}

variable "aci_password" {
  type    = string
  default = null
}

variable "aci_private_key" {
  type    = string
  default = null
}

variable "aci_url" {
  type    = string
  default = null
}

variable "aci_insecure" {
  type    = bool
  default = null
}

variable "aci_validate_relation_dn" {
  type    = bool
  default = null
}

variable "aci_cert_name" {
  type    = string
  default = null
}

variable "aci_proxy_url" {
  type    = string
  default = null
}

variable "aci_proxy_creds" {
  type    = string
  default = null
}

variable "aci_retries" {
  type    = number
  default = null
}


locals {
  aci_hostname = replace(var.aci_url, "/(https?://)|(/)|(:.*)/", "")
}

module "aci_provider_secret" {
  count           = length(compact([var.aci_password])) > 0 ? 0 : 1
  source          = "github.com/northvolt/tf-mod-common//secrets?ref=v2.2.0"
  secret_name     = try(coalesce(var.aci_secret_name), local.aci_hostname)
  secret_name_key = try(coalesce(var.aci_secret_name_key), var.aci_username)
  secret_path     = try(coalesce(var.aci_secret_path), null)
  store           = try(coalesce(var.aci_secret_store), "secrets-manager")
%{if local.all_vars.aci_secret_aws_profile != null~}
  providers = {
    aws = aws.aci_secret
  }
%{endif~}
}

provider "aci" {
  username             = try(coalesce(var.aci_username), null)
  password             = try(coalesce(var.aci_password), module.aci_provider_secret[0].secret)
  private_key          = try(coalesce(var.aci_private_key), null)
  url                  = try(coalesce(var.aci_url), null)
  insecure             = try(coalesce(var.aci_insecure), null)
  validate_relation_dn = try(coalesce(var.aci_validate_relation_dn), null)
  cert_name            = try(coalesce(var.aci_cert_name), null)
  proxy_url            = try(coalesce(var.aci_proxy_url), null)
  proxy_creds          = try(coalesce(var.aci_proxy_creds), null)
  retries              = try(coalesce(var.aci_retries), null)
}

%{if local.all_vars.aci_secret_aws_profile != null~}
provider "aws" {
  region  = "${coalesce(local.all_vars.aci_secret_aws_region, local.aws_region, "eu-north-1")}"
  profile = "${local.all_vars.aci_secret_aws_profile}"
  alias   = "aci_secret"
}
%{endif~}
EOF
    }
  }

  generate_aci_provider_override = {
    aci_provider_override = {
      path      = "tg_generated_provider_aci_override.tf"
      if_exists = "overwrite"
      contents  = <<EOF
terraform {
  required_providers {
    aci = {
      source  = "ciscodevnet/aci"
      version = "${try(coalesce(local.all_vars.aci_provider_version), "")}"
    }
  }
}
EOF
    }
  }

  # generate mongodbatlas provider
  generate_mongodbatlas_provider = {
    mongodbatlas_provider = {
      path      = "tg_generated_provider_mongodbatlas.tf"
      if_exists = "overwrite"
      contents  = <<EOF
variable "mongodbatlas_secret_name" {
  type    = string
  default = null
}

variable "mongodbatlas_secret_name_key" {
  type    = string
  default = null
}

variable "mongodbatlas_secret_store" {
  type    = string
  default = null
}

variable "mongodbatlas_secret_path" {
  type    = string
  default = null
}

variable "mongodbatlas_public_key" {
  description = "The public API key for MongoDB Atlas"
  default     = null
}

variable "mongodbatlas_private_key" {
  description = "The private API key for MongoDB Atlas"
  default     = null
}

module "mongodbatlas_provider_secret" {
  for_each = toset(compact([
    length(compact([var.mongodbatlas_public_key])) > 0 ? "" : "public_key",
    length(compact([var.mongodbatlas_private_key])) > 0 ? "" : "private_key",
  ]))
  source          = "github.com/northvolt/tf-mod-common//secrets?ref=v2.2.0"
  secret_name     = try(coalesce(var.mongodbatlas_secret_name), "mongodbatlas")
  secret_name_key = each.value
  secret_path     = try(coalesce(var.mongodbatlas_secret_path), null)
  store           = try(coalesce(var.mongodbatlas_secret_store), "secrets-manager")
%{if local.all_vars.mongodbatlas_secret_aws_profile != null~}
  providers = {
    aws = aws.mongodbatlas_secret
  }
%{endif~}
}

provider "mongodbatlas" {
  public_key  = length(compact([var.mongodbatlas_public_key])) > 0 ? var.mongodbatlas_public_key : module.mongodbatlas_provider_secret["public_key"].secret
  private_key = length(compact([var.mongodbatlas_private_key])) > 0 ? var.mongodbatlas_private_key : module.mongodbatlas_provider_secret["private_key"].secret
}

%{if local.all_vars.mongodbatlas_secret_aws_profile != null~}
provider "aws" {
  region  = "${coalesce(local.all_vars.mongodbatlas_secret_aws_region, local.aws_region, "eu-north-1")}"
  profile = "${local.all_vars.mongodbatlas_secret_aws_profile}"
  alias   = "mongodbatlas_secret"
}
%{endif~}
EOF
    }
  }

  generate_mongodbatlas_provider_override = {
    mongodbatlas_provider_override = {
      path      = "tg_generated_provider_mongodbatlas_override.tf"
      if_exists = "overwrite"
      contents  = <<EOF
terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
      version = "${try(coalesce(local.all_vars.mongodbatlas_provider_version), "")}"
    }
  }
}
EOF
    }
  }

  # generate opsgenie provider
  generate_opsgenie_provider = {
    opsgenie_provider = {
      path      = "tg_generated_provider_opsgenie.tf"
      if_exists = "overwrite"
      contents  = <<EOF
variable "opsgenie_secret_name" {
  type    = string
  default = null
}

variable "opsgenie_secret_name_key" {
  type    = string
  default = null
}

variable "opsgenie_secret_store" {
  type    = string
  default = null
}

variable "opsgenie_secret_path" {
  type    = string
  default = null
}

variable "opsgenie_api_key" {
  description = "(Required) The API Key for the Opsgenie Integration. If omitted, the OPSGENIE_API_KEY environment variable is used."
  default     = null
}

variable "opsgenie_api_url" {
  description = "(Optional) The API url for the Opsgenie."
  default     = null
}

module "opsgenie_provider_secret" {
  for_each = toset(compact([
    length(compact([var.opsgenie_api_key])) > 0 ? "" : "api_key",
    length(compact([var.opsgenie_api_url])) > 0 ? "" : "api_url",
  ]))
  source          = "github.com/northvolt/tf-mod-common//secrets?ref=v2.2.0"
  secret_name     = try(coalesce(var.opsgenie_secret_name), "opsgenie")
  secret_name_key = each.value
  secret_path     = try(coalesce(var.opsgenie_secret_path), null)
  store           = try(coalesce(var.opsgenie_secret_store), "secrets-manager")
%{if local.all_vars.opsgenie_secret_aws_profile != null~}
  providers = {
    aws = aws.opsgenie_secret
  }
%{endif~}
}

provider "opsgenie" {
  api_key = length(compact([var.opsgenie_api_key])) > 0 ? var.opsgenie_api_key : module.opsgenie_provider_secret["api_key"].secret
  api_url = length(compact([var.opsgenie_api_url])) > 0 ? var.opsgenie_api_url : module.opsgenie_provider_secret["api_url"].secret
}

%{if local.all_vars.opsgenie_secret_aws_profile != null~}
provider "aws" {
  region  = "${coalesce(local.all_vars.opsgenie_secret_aws_region, local.aws_region, "eu-north-1")}"
  profile = "${local.all_vars.opsgenie_secret_aws_profile}"
  alias   = "opsgenie_secret"
}
%{endif~}
EOF
    }
  }

  generate_opsgenie_provider_override = {
    opsgenie_provider_override = {
      path      = "tg_generated_provider_opsgenie_override.tf"
      if_exists = "overwrite"
      contents  = <<EOF
terraform {
  required_providers {
    opsgenie = {
      source = "opsgenie/opsgenie"
      version = "${try(coalesce(local.all_vars.opsgenie_provider_version), "")}"
    }
  }
}
EOF
    }
  }

  # generate github provider
  generate_github_provider = {
    github_provider = {
      path      = "tg_generated_provider_github.tf"
      if_exists = "overwrite"
      contents  = <<EOF
variable "github_token" {
  description = "(Optional) A GitHub OAuth / Personal Access Token. When not provided or made available via the GITHUB_TOKEN environment variable, the provider can only access resources available anonymously."
  type        = string
  default     = null
}

variable "github_base_url" {
  description = "(Optional) This is the target GitHub base API endpoint. Providing a value is a requirement when working with GitHub Enterprise. It is optional to provide this value and it can also be sourced from the GITHUB_BASE_URL environment variable. The value must end with a slash, for example: https://terraformtesting-ghe.westus.cloudapp.azure.com/"
  type        = string
  default     = null
}

variable "github_owner" {
  description = "(Optional) This is the target GitHub organization or individual user account to manage. For example, torvalds and github are valid owners. It is optional to provide this value and it can also be sourced from the GITHUB_OWNER environment variable. When not provided and a token is available, the individual user account owning the token will be used. When not provided and no token is available, the provider may not function correctly."
  type        = string
  default     = null
}

variable "github_app_auth" {
  description = "(Optional) Configuration block to use GitHub App installation token. When not provided, the provider can only access resources available anonymously."
  type        = map(string)
  default     = {}
}

variable "github_write_delay_ms" {
  description = "(Optional) The number of milliseconds to sleep in between write operations in order to satisfy the GitHub API rate limits. Defaults to 1000ms or 1 second if not provided."
  type        = number
  default     = null
}

variable "github_read_delay_ms" {
  description = "(Optional) The num"
  type        = number
  default     = null
}

provider "github" {
  token        = var.github_token
  base_url     = var.github_base_url
  owner        = var.github_owner

  dynamic "app_auth" {
    for_each = length(var.github_app_auth) > 0 ? [var.github_app_auth] : []
    content {
      id              = try(app_auth.value.id, null)
      installation_id = try(app_auth.value.installation_id, null)
      pem_file        = try(app_auth.value.pem_file, null)
    }
  }

  write_delay_ms = var.github_write_delay_ms
  read_delay_ms  = var.github_read_delay_ms
}

EOF
    }
  }

  generate_github_provider_override = {
    github_provider_override = {
      path      = "tg_generated_provider_github_override.tf"
      if_exists = "overwrite"
      contents  = <<EOF
terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "${try(coalesce(local.all_vars.github_provider_version), "")}"
    }
  }
}
EOF
    }
  }

  # generate grafana provider
  generate_grafana_provider = {
    grafana_provider = {
      path      = "tg_generated_provider_grafana.tf"
      if_exists = "overwrite"
      contents  = <<-EOF
variable "grafana_secret_name" {
  type    = string
  default = null
}

variable "grafana_secret_name_key" {
  type    = string
  default = null
}

variable "grafana_secret_store" {
  type    = string
  default = null
}

variable "grafana_secret_path" {
  type    = string
  default = null
}

variable "grafana_auth" {
  description = "(String, Sensitive) API token or basic auth username:password. May alternatively be set via the GRAFANA_AUTH environment variable."
  type        = string
  default     = null
}

variable "grafana_ca_cert" {
  description = "(String) Certificate CA bundle to use to verify the Grafana server's certificate. May alternatively be set via the GRAFANA_CA_CERT environment variable."
  type        = string
  default     = null
}

variable "grafana_cloud_api_key" {
  description = "(String, Sensitive) API key for Grafana Cloud. May alternatively be set via the GRAFANA_CLOUD_API_KEY environment variable."
  type        = string
  default     = null
}

variable "grafana_cloud_api_url" {
  description = "(String) Grafana Cloud's API URL. May alternatively be set via the GRAFANA_CLOUD_API_URL environment variable."
  type        = string
  default     = null
}

variable "grafana_http_headers" {
  description = "(Map of String, Sensitive) Optional. HTTP headers mapping keys to values used for accessing the Grafana API. May alternatively be set via the GRAFANA_HTTP_HEADERS environment variable in JSON format."
  type        = map(string)
  default     = null
}

variable "grafana_insecure_skip_verify" {
  description = "(Boolean) Skip TLS certificate verification. May alternatively be set via the GRAFANA_INSECURE_SKIP_VERIFY environment variable."
  type        = bool
  default     = null
}

variable "grafana_oncall_access_token" {
  description = "(String, Sensitive) A Grafana OnCall access token. May alternatively be set via the GRAFANA_ONCALL_ACCESS_TOKEN environment variable."
  type        = string
  default     = null
}

variable "grafana_oncall_url" {
  description = "(String) An Grafana OnCall backend address. May alternatively be set via the GRAFANA_ONCALL_URL environment variable."
  type        = string
  default     = null
}

variable "grafana_org_id" {
  description = "(Number) The organization id to operate on within grafana. May alternatively be set via the GRAFANA_ORG_ID environment variable."
  type        = number
  default     = null
}

variable "grafana_retries" {
  description = "(Number) The amount of retries to use for Grafana API calls. May alternatively be set via the GRAFANA_RETRIES environment variable."
  type        = number
  default     = null
}

variable "grafana_sm_access_token" {
  description = "(String, Sensitive) A Synthetic Monitoring access token. May alternatively be set via the GRAFANA_SM_ACCESS_TOKEN environment variable."
  type        = string
  default     = null
}

variable "grafana_sm_url" {
  description = "(String) Synthetic monitoring backend address. May alternatively be set via the GRAFANA_SM_URL environment variable. The correct value for each service region is cited in the Synthetic Monitoring documentation. Note the sm_url value is optional, but it must correspond with the value specified as the region_slug in the grafana_cloud_stack resource. Also note that when a Terraform configuration contains multiple provider instances managing SM resources associated with the same Grafana stack, specifying an explicit sm_url set to the same value for each provider ensures all providers interact with the same SM API."
  type        = string
  default     = null
}

variable "grafana_store_dashboard_sha256" {
  description = "(Boolean) Set to true if you want to save only the sha256sum instead of complete dashboard model JSON in the tfstate."
  type        = bool
  default     = null
}

variable "grafana_tls_cert" {
  description = "(String) Client TLS certificate file to use to authenticate to the Grafana server. May alternatively be set via the GRAFANA_TLS_CERT environment variable."
  type        = string
  default     = null
}

variable "grafana_tls_key" {
  description = "(String) Client TLS key file to use to authenticate to the Grafana server. May alternatively be set via the GRAFANA_TLS_KEY environment variable."
  type        = string
  default     = null
}

variable "grafana_url" {
  description = "(String) The root URL of a Grafana server. May alternatively be set via the GRAFANA_URL environment variable."
  type        = string
  default     = null
}

module "grafana_provider_secret" {
  count           = length(compact([var.grafana_auth])) == 0 ? 1 : 0
  source          = "github.com/northvolt/tf-mod-common//secrets?ref=v2.2.0"
  secret_name     = try(coalesce(var.grafana_secret_name), "api_key")
  secret_name_key = try(coalesce(var.grafana_secret_name_key), "api_key")
  secret_path     = try(coalesce(var.grafana_secret_path), "/grafana")
  store           = try(coalesce(var.grafana_secret_store), "parameter-store")
%{if local.all_vars.grafana_secret_aws_profile != null~}
  providers = {
    aws = aws.grafana_secret
  }
%{endif~}
}

provider "grafana" {
  auth                   = try(coalesce(var.grafana_auth), module.grafana_provider_secret[0].secret)
  ca_cert                = var.grafana_ca_cert
  cloud_api_key          = var.grafana_cloud_api_key
  cloud_api_url          = var.grafana_cloud_api_url
  http_headers           = var.grafana_http_headers
  insecure_skip_verify   = var.grafana_insecure_skip_verify
  oncall_access_token    = var.grafana_oncall_access_token
  oncall_url             = var.grafana_oncall_url
  org_id                 = var.grafana_org_id
  retries                = var.grafana_retries
  sm_access_token        = var.grafana_sm_access_token
  sm_url                 = var.grafana_sm_url
  store_dashboard_sha256 = var.grafana_store_dashboard_sha256
  tls_cert               = var.grafana_tls_cert
  tls_key                = var.grafana_tls_key
  url                    = var.grafana_url
}

%{if local.all_vars.grafana_secret_aws_profile != null~}
provider "aws" {
  region  = "${coalesce(local.all_vars.grafana_secret_aws_region, local.aws_region, "eu-north-1")}"
  profile = "${local.all_vars.grafana_secret_aws_profile}"
  alias   = "grafana_secret"
}
%{endif~}
EOF
    }
  }

  generate_grafana_provider_override = {
    grafana_provider_override = {
      path      = "tg_generated_provider_grafana_override.tf"
      if_exists = "overwrite"
      contents  = <<-EOF
terraform {
  required_providers {
    grafana = {
      source = "grafana/grafana"
      version = "${try(coalesce(local.all_vars.grafana_provider_version), "")}"
    }
  }
}
EOF
    }
  }

  # generate aviatrix provider
  generate_aviatrix_provider = {
    aviatrix_provider = {
      path      = "tg_generated_provider_aviatrix.tf"
      if_exists = "overwrite"
      contents  = <<EOF
variable "aviatrix_secret_name" {
  type    = string
  default = null
}

variable "aviatrix_secret_name_key" {
  type    = string
  default = null
}

variable "aviatrix_secret_store" {
  type    = string
  default = null
}

variable "aviatrix_secret_path" {
  type    = string
  default = null
}

variable "aviatrix_controller_ip" {
  type    = string
  default = null
}

variable "aviatrix_username" {
  type    = string
  default = null
}

variable "aviatrix_password" {
  type    = string
  default = null
}

variable "aviatrix_skip_version_validation" {
  description = "(Optional) Valid values: true, false. Default: false. If set to true, it skips checking whether current Terraform provider supports current Controller version."
  type = bool
  default = null
}

variable "aviatrix_verify_ssl_certificate" {
  description = "(Optional) Valid values: true, false. Default: false. If set to true, the SSL certificate of the controller will be verified."
  type = bool
  default = null
}

variable "aviatrix_path_to_ca_certificate" {
  description = "(Optional) Specify the path to the root CA certificate. Valid only when verify_ssl_certificate is true. The CA certificate is required when the controller is using a self-signed certificate."
  type = string
  default = null
}

module "aviatrix_provider_secret" {
  count           = length(compact([var.aviatrix_password])) > 0 ? 0 : 1
  source          = "github.com/northvolt/tf-mod-common//secrets?ref=v2.2.0"
  secret_name     = try(coalesce(var.aviatrix_secret_name), "aviatrix/controller")
  secret_name_key = try(coalesce(var.aviatrix_secret_name_key), "password")
  secret_path     = try(coalesce(var.aviatrix_secret_path), "/aviatrix")
  store           = try(coalesce(var.aviatrix_secret_store), "parameter-store")
%{if local.all_vars.aviatrix_secret_aws_profile != null~}
  providers = {
    aws = aws.aviatrix_secret
  }
%{endif~}
}

provider "aviatrix" {
  controller_ip           = var.aviatrix_controller_ip
  username                = var.aviatrix_username
  password                = try(coalesce(var.aviatrix_password), module.aviatrix_provider_secret[0].secret)
  skip_version_validation = var.aviatrix_skip_version_validation
  verify_ssl_certificate  = var.aviatrix_verify_ssl_certificate
  path_to_ca_certificate  = var.aviatrix_path_to_ca_certificate
}

%{if local.all_vars.aviatrix_secret_aws_profile != null~}
provider "aws" {
  region  = "${coalesce(local.all_vars.aviatrix_secret_aws_region, local.aws_region, "eu-north-1")}"
  profile = "${local.all_vars.aviatrix_secret_aws_profile}"
  alias   = "aviatrix_secret"
}
%{endif~}
EOF
    }
  }

  generate_aviatrix_provider_override = {
    aviatrix_provider_override = {
      path      = "tg_generated_provider_aviatrix_override.tf"
      if_exists = "overwrite"
      contents  = <<EOF
terraform {
  required_providers {
    aviatrix = {
      source  = "AviatrixSystems/aviatrix"
      version = "${try(coalesce(local.all_vars.aviatrix_provider_version), "")}"
    }
  }
}
EOF
    }
  }

  all_providers = local.all_vars.providers_override != null ? local.all_vars.providers_override : distinct(concat(
    try(local.default_vars.providers, []),
    try(local.global_vars.locals.providers, []),
    try(local.provider_vars.locals.providers, []),
    try(local.account_vars.locals.providers, []),
    try(local.environment_vars.locals.providers, []),
    try(local.region_vars.locals.providers, []),
    try(local.project_vars.locals.providers, []),
    try(local.general_vars.locals.providers, []),
    try(local.common_vars.locals.providers, []),
    try(local.local_vars.locals.providers, []),
  ))

  all_delete_files = local.all_vars.delete_files_override != null ? local.all_vars.delete_files_override : distinct(concat(
    try(local.default_vars.delete_files, []),
    try(local.global_vars.locals.delete_files, []),
    try(local.provider_vars.locals.delete_files, []),
    try(local.account_vars.locals.delete_files, []),
    try(local.environment_vars.locals.delete_files, []),
    try(local.region_vars.locals.delete_files, []),
    try(local.project_vars.locals.delete_files, []),
    try(local.general_vars.locals.delete_files, []),
    try(local.common_vars.locals.delete_files, []),
    try(local.local_vars.locals.delete_files, []),
  ))

  # generate delete files
  generate_delete_files = { for file in toset(local.all_delete_files) :
    format("%s%s", "delete_", file) => {
      path      = file
      if_exists = "overwrite"
      contents  = ""
    }
  }


  generate_additional_providers = {
    for provider in local.all_vars.additional_providers :
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
            ${block_k} = ${block_v}
%{endfor~}
          }
%{endfor~}
%{endif~}
%{endfor~}
        }
        EOF
    }
  }
  generate = merge(
    local.generate_delete_files,
    try(length(compact([local.all_vars.terraform_required_version])) > 0 ? local.generate_versions : tomap(false), {}),
    try(contains(local.all_providers, "aws") ? local.generate_aws_provider : tomap(false), {}),
    try(length(compact([local.all_vars.aws_provider_version])) > 0 ? local.generate_aws_provider_override : tomap(false), {}),
    try(contains(local.all_providers, "azurerm") ? local.generate_azurerm_provider : tomap(false), {}),
    try(length(compact([local.all_vars.azurerm_provider_version])) > 0 ? local.generate_azurerm_provider_override : tomap(false), {}),
    try(contains(local.all_providers, "azuread") ? local.generate_azuread_provider : tomap(false), {}),
    try(length(compact([local.all_vars.azuread_provider_version])) > 0 ? local.generate_azuread_provider_override : tomap(false), {}),
    try(contains(local.all_providers, "guacamole") ? local.generate_guacamole_provider : tomap(false), {}),
    try(length(compact([local.all_vars.guacamole_provider_version])) > 0 ? local.generate_guacamole_provider_override : tomap(false), {}),
    try(contains(local.all_providers, "proxmox") ? local.generate_proxmox_provider : tomap(false), {}),
    try(length(compact([local.all_vars.proxmox_provider_version])) > 0 ? local.generate_proxmox_provider_override : tomap(false), {}),
    try(contains(local.all_providers, "vsphere") ? local.generate_vsphere_provider : tomap(false), {}),
    try(length(compact([local.all_vars.vsphere_provider_version])) > 0 ? local.generate_vsphere_provider_override : tomap(false), {}),
    try(contains(local.all_providers, "kubernetes_eks") ? local.generate_kubernetes_eks_provider : tomap(false), {}),
    try(length(compact([local.all_vars.kubernetes_eks_provider_version])) > 0 ? local.generate_kubernetes_eks_provider_override : tomap(false), {}),
    try(contains(local.all_providers, "helm_eks") ? local.generate_helm_eks_provider : tomap(false), {}),
    try(length(compact([local.all_vars.helm_eks_provider_version])) > 0 ? local.generate_helm_eks_provider_override : tomap(false), {}),
    try(contains(local.all_providers, "mysql") ? local.generate_mysql_provider : tomap(false), {}),
    try(length(compact([local.all_vars.mysql_provider_version])) > 0 ? local.generate_mysql_provider_override : tomap(false), {}),
    try(contains(local.all_providers, "postgresql") ? local.generate_postgresql_provider : tomap(false), {}),
    try(length(compact([local.all_vars.postgresql_provider_version])) > 0 ? local.generate_postgresql_provider_override : tomap(false), {}),
    try(contains(local.all_providers, "mssql") ? local.generate_mssql_provider : tomap(false), {}),
    try(length(compact([local.all_vars.mssql_provider_version])) > 0 ? local.generate_mssql_provider_override : tomap(false), {}),
    try(contains(local.all_providers, "aci") ? local.generate_aci_provider : tomap(false), {}),
    try(length(compact([local.all_vars.aci_provider_version])) > 0 ? local.generate_aci_provider_override : tomap(false), {}),
    try(contains(local.all_providers, "mongodbatlas") ? local.generate_mongodbatlas_provider : tomap(false), {}),
    try(length(compact([local.all_vars.mongodbatlas_provider_version])) > 0 ? local.generate_mongodbatlas_provider_override : tomap(false), {}),
    try(contains(local.all_providers, "opsgenie") ? local.generate_opsgenie_provider : tomap(false), {}),
    try(length(compact([local.all_vars.opsgenie_provider_version])) > 0 ? local.generate_opsgenie_provider_override : tomap(false), {}),
    try(contains(local.all_providers, "github") ? local.generate_github_provider : tomap(false), {}),
    try(length(compact([local.all_vars.github_provider_version])) > 0 ? local.generate_github_provider_override : tomap(false), {}),
    try(contains(local.all_providers, "grafana") ? local.generate_grafana_provider : tomap(false), {}),
    try(length(compact([local.all_vars.grafana_provider_version])) > 0 ? local.generate_grafana_provider_override : tomap(false), {}),
    try(contains(local.all_providers, "aviatrix") ? local.generate_aviatrix_provider : tomap(false), {}),
    try(length(compact([local.all_vars.aviatrix_provider_version])) > 0 ? local.generate_aviatrix_provider_override : tomap(false), {}),
    try(length(local.generate_additional_providers) > 0 ? local.generate_additional_providers : tomap(false), {}),
    local.global_vars.generate,
    local.provider_vars.generate,
    local.account_vars.generate,
    local.environment_vars.generate,
    local.region_vars.generate,
    local.project_vars.generate,
    local.general_vars.generate,
    local.common_vars.generate,
    local.local_vars.generate,
    {},
  )

}

remote_state = merge(
  try(local.local_state_enabled ? local.generate_local_state : tomap(false), {}),
  try(local.remote_state_s3_enabled ? local.generate_remote_state_s3 : tomap(false), {}),
  try(local.remote_state_azurerm_enabled ? local.generate_remote_state_azurerm : tomap(false), {}),
  {},
)

generate = local.generate

inputs = merge(
  { for k, v in local.all_vars : k => v if v != null && v != [] && v != "" && v != {} },
  try(contains(local.all_providers, "azurerm") || contains(local.all_providers, "proxmox") ? { repo_tag = { "repo" : "${basename(get_parent_terragrunt_dir())}/${path_relative_to_include()}" } } : tomap(false), {}),
  try(contains(local.all_providers, "azurerm") ? { env_tag = { "environment" : "${local.environment}" } } : tomap(false), {}),
  contains(local.all_providers, "proxmox") ? length(local.all_vars.tags) > 0 ? { tags = join("\n", [for k in local.all_vars.tags : k]) } : { tags = "" } : {},
  contains(local.all_providers, "vsphere") ? { env_tag = local.environment } : {},
  contains(local.all_providers, "vsphere") ? { repo_tag = "${basename(get_parent_terragrunt_dir())}/${path_relative_to_include()}" } : {},
  length(compact([local.aws_region])) == 0 ? { aws_region = "" } : {},
  length(compact([local.aws_profile])) > 0 ? { aws_profile = local.aws_profile } : {},
)

