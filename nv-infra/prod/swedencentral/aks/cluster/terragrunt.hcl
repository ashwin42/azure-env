terraform {
  source = "tfr:///Azure/aks/azurerm?version=7.5.0"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../../nv-infra-swc-vnet"
}

dependency "acr" {
  config_path = "../../acr/registry"
}

inputs = {
  agents_availability_zones          = ["1", "2", "3"]
  agents_max_count                   = 9
  agents_min_count                   = 3
  agents_size                        = "Standard_D2s_v5"
  automatic_channel_upgrade          = "stable"
  azure_policy_enabled               = true
  cluster_name                       = include.root.inputs.cluster_name
  enable_auto_scaling                = true
  key_vault_secrets_provider_enabled = true
  local_account_disabled             = true
  log_analytics_workspace_enabled    = false
  log_analytics_workspace_enabled    = true
  net_profile_dns_service_ip         = "172.20.0.10"
  net_profile_service_cidr           = "172.20.0.0/16"
  network_plugin                     = "azure"
  network_plugin_mode                = "overlay"
  network_policy                     = "azure"
  oidc_issuer_enabled                = true
  prefix                             = "infra"
  rbac_aad_admin_group_object_ids    = ["dfa1d998-98ad-4935-856d-6bfa7daa1201"] # NV TechOps Role
  rbac_aad_azure_rbac_enabled        = true
  rbac_aad_managed                   = true
  rbac_aad                           = true
  role_based_access_control_enabled  = true
  sku_tier                           = "Free"
  vnet_subnet_id                     = dependency.vnet.outputs.subnets["nv-gen-infra-swc-aks-subnet"].id
  workload_identity_enabled          = true
  microsoft_defender_enabled         = true
  network_contributor_role_assigned_subnet_ids = {
    "nv-gen-infra-swc-aks-subnet"         = dependency.vnet.outputs.subnets["nv-gen-infra-swc-aks-subnet"].id
    "nv-gen-infra-swc-aks-ingress-subnet" = dependency.vnet.outputs.subnets["nv-gen-infra-swc-aks-ingress-subnet"].id
  }
  attached_acr_id_map = {
    (dependency.acr.outputs.name) = dependency.acr.outputs.id
  }
}
