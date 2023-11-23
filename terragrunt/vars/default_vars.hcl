locals {
  # general
  terraform_required_version    = null
  terraform_version_constraint  = null
  terragrunt_version_constraint = ">= 0.36.3"
  environment                   = null
  tags                          = {}
  tags_override                 = null
  tags_null                     = false
  providers                     = []
  providers_override            = null
  delete_files                  = []
  delete_files_override         = null
  additional_providers          = []
  additional_providers_override = null
  # local backend
  local_state_enabled = null
  local_state_path    = "${get_original_terragrunt_dir()}/terraform.tfstate"
  # s3 backend
  remote_state_s3_enabled                      = null
  remote_state_s3_key_prefix                   = null
  remote_state_s3_path                         = null
  remote_state_s3_encrypt                      = null
  remote_state_s3_bucket                       = null
  remote_state_s3_region                       = null
  remote_state_s3_dynamodb_table               = null
  remote_state_s3_skip_region_validation       = null
  remote_state_s3_role_arn                     = null
  remote_state_s3_bucket_tags                  = {}
  remote_state_s3_dynamodb_table_tags          = {}
  remote_state_s3_bucket_tags_override         = {}
  remote_state_s3_dynamodb_table_tags_override = {}
  # azurerm backend
  remote_state_azurerm_enabled              = null
  remote_state_azurerm_storage_account_name = null
  remote_state_azurerm_container_name       = null
  remote_state_azurerm_key                  = null
  remote_state_azurerm_resource_group_name  = null
  remote_state_azurerm_subscription_id      = null
  # aws
  aws_provider_source  = "hashicorp/aws"
  aws_provider_version = null
  aws_region           = null
  region               = null
  aws_profile          = null
  account_name         = "default"
  account_id           = ""
  aws_account_id       = null
  allowed_account_ids  = []
  aws_assume_role_arn  = null
  # azurerm
  azurerm_provider_source              = "hashicorp/azurerm"
  azurerm_provider_version             = null
  azurerm_features                     = null
  azurerm_subscription_id              = null
  azurerm_oidc_request_token           = null
  azurerm_oidc_request_url             = null
  azurerm_use_oidc                     = null
  azurerm_disable_terraform_partner_id = null
  azurerm_metadata_host                = null
  azurerm_storage_use_azuread          = null
  # azapi
  azapi_provider_source  = "Azure/azapi"
  azapi_provider_version = null
  # azuread
  azuread_provider_source    = "hashicorp/azuread"
  azuread_provider_version   = null
  azuread_client_certificate = null
  azuread_oidc_request_token = null
  azuread_oidc_request_url   = null
  azuread_use_oidc           = null
  azuread_use_cli            = null
  # guacamole
  guacamole_provider_source    = "techBeck03/guacamole"
  guacamole_provider_version   = null
  guacamole_secret_aws_profile = null
  guacamole_secret_aws_region  = null
  # proxmox
  proxmox_provider_source    = "Telmate/proxmox"
  proxmox_provider_version   = null
  proxmox_secret_aws_profile = null
  proxmox_secret_aws_region  = null
  # vsphere
  vsphere_provider_source    = "hashicorp/vsphere"
  vsphere_provider_version   = null
  vsphere_secret_aws_profile = null
  vsphere_secret_aws_region  = null
  # kubernetes_eks
  kubernetes_eks_provider_source       = "hashicorp/kubernetes"
  kubernetes_eks_provider_version      = null
  kubernetes_eks_cluster_name          = null
  kubernetes_eks_api_version           = "client.authentication.k8s.io/v1alpha1"
  kubernetes_eks_aws_profile           = null
  kubernetes_eks_aws_region            = null
  kubernetes_eks_greenfield_deployment = false
  # kubernetes_k3s
  kubernetes_k3s_provider_source  = "hashicorp/kubernetes"
  kubernetes_k3s_provider_version = null
  # helm_k3s
  helm_k3s_provider_source  = "hashicorp/helm"
  helm_k3s_provider_version = null
  # rancher2
  rancher2_provider_source  = "rancher/rancher2"
  rancher2_provider_version = null
  rancher2_cluster_manager  = null
  # kubernetes_alpha_eks
  kubernetes_alpha_eks_provider_source  = "hashicorp/kubernetes-alpha"
  kubernetes_alpha_eks_provider_version = null
  # helm_eks
  helm_eks_provider_source         = "hashicorp/helm"
  helm_eks_provider_version        = null
  helm_eks_kubernetes_cluster_name = null
  helm_eks_kubernetes_api_version  = "client.authentication.k8s.io/v1alpha1"
  helm_eks_aws_profile             = null
  helm_eks_aws_region              = null
  # mysql
  mysql_provider_source    = "petoju/mysql"
  mysql_provider_version   = null
  mysql_secret_aws_profile = null
  mysql_secret_aws_region  = null
  # postgresql
  postgresql_provider_source    = "cyrilgdn/postgresql"
  postgresql_provider_version   = null
  postgresql_secret_aws_profile = null
  postgresql_secret_aws_region  = null
  # mssql
  mssql_provider_source  = "betr-io/mssql"
  mssql_provider_version = null
  # aci
  aci_provider_version   = null
  aci_provider_source    = "ciscodevnet/aci"
  aci_secret_aws_profile = null
  aci_secret_aws_region  = null
  # mongodbatlas
  mongodbatlas_provider_source    = "mongodb/mongodbatlas"
  mongodbatlas_provider_version   = null
  mongodbatlas_secret_aws_profile = null
  mongodbatlas_secret_aws_region  = null
  # opsgenie
  opsgenie_provider_source    = "opsgenie/opsgenie"
  opsgenie_provider_version   = null
  opsgenie_secret_aws_profile = null
  opsgenie_secret_aws_region  = null
  # github
  github_provider_source  = "integrations/github"
  github_provider_version = null
  # grafana
  grafana_provider_source    = "grafana/grafana"
  grafana_provider_version   = null
  grafana_secret_aws_profile = null
  grafana_secret_aws_region  = null
  # aviatrix
  aviatrix_provider_source    = "aviatrixsystems/aviatrix"
  aviatrix_provider_version   = null
  aviatrix_contoller_ip       = null
  aviatrix_secret_aws_profile = null
  aviatrix_secret_aws_region  = null
  aviatrix_assume_role_arn    = null
  # vault
  vault_provider_source  = "hashicorp/vault"
  vault_provider_version = null
  # restapi
  restapi_provider_source    = "Mastercard/restapi"
  restapi_provider_version   = null
  restapi_secret_aws_profile = null
  restapi_secret_aws_region  = null
  # phillbaker/elasticsearch
  elasticsearch_provider_source  = "phillbaker/elasticsearch"
  elasticsearch_provider_version = null
  # tls
  tls_provider_source  = "hashicorp/tls"
  tls_provider_version = null
  # panos
  panos_provider_source    = "PaloAltoNetworks/panos"
  panos_provider_version   = null
  panos_secret_aws_profile = null
  panos_secret_aws_region  = null
  # netbox
  netbox_provider_source    = "e-breuninger/netbox"
  netbox_provider_version   = null
  netbox_secret_aws_profile = null
  netbox_secret_aws_region  = null
  # awx
  awx_provider_source    = "ilijamt/awx"
  awx_provider_version   = null
  awx_secret_aws_profile = null
  awx_secret_aws_region  = null
  # databricks
  databricks_provider_source       = "databricks/databricks"
  databricks_provider_version      = null
  databricks_secret_aws_profile    = null
  databricks_secret_aws_region     = null
  databricks_secret_cloud_provider = null
}
