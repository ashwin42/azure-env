terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//aks/core-services?ref=v0.10.0"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/aks//core-services"
}

dependency "cluster" {
  config_path = "../cluster"
}

dependency "dns" {
  config_path = "../../../global/dns/${include.root.inputs.dns_domain}"
}

dependency "vault" {
  config_path = "../../../westeurope/global/vaults/secrets"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  helm_aks_cluster_name        = dependency.cluster.outputs.aks_name
  helm_aks_resource_group_name = include.root.inputs.resource_group_name

  ## Ingress
  nginx_ingress = {
    enable                 = true
    enable_private_ingress = true
    private_ingress_subnet = "nv-gen-infra-swc-aks-ingress-subnet"
    values                 = <<-EOF
    controller:
      replicaCount: 2
      service:
        externalTrafficPolicy: Local
        annotations:
          "service.beta.kubernetes.io/azure-load-balancer-health-probe-request-path": /healthz
    EOF
  }

  ## Cert Manager
  cert_manager = {
    enable = true
    cluster_issuer = {
      acme_settings = {
        email               = "techops@northvolt.com"
        zone_name           = dependency.dns.outputs.dns_zones[include.root.inputs.dns_domain].name
        resource_group_name = dependency.dns.outputs.dns_zones[include.root.inputs.dns_domain].resource_group_name
      }
    }
    user_assigned_identity = {
      name         = "cert-manager-infra-aks"
      dns_zone_ids = [dependency.dns.outputs.dns_zones[include.root.inputs.dns_domain].id]
      federated_identity_credentials = [{
        name   = "cert-manager-infra-aks"
        issuer = dependency.cluster.outputs.oidc_issuer_url
      }]
    }
  }

  ## External DNS
  external_dns = {
    enable = true
    settings = {
      dns_resource_group_name = dependency.dns.outputs.dns_zones[include.root.inputs.dns_domain].resource_group_name
    }
  }

  ## External Secrets
  external_secrets_operator = {
    enable = true
    settings = {
      service_account_name = "external-secrets"
    }
    user_assigned_identity = {
      name          = "external-secrets-infra-aks"
      key_vault_ids = [dependency.vault.outputs.azurerm_key_vault.id]
      federated_identity_credentials = [{
        name   = "external-secrets-infra-aks"
        issuer = dependency.cluster.outputs.oidc_issuer_url
      }]
    }
    cluster_secret_store = {
      enable    = true
      vault_url = dependency.vault.outputs.azurerm_key_vault.vault_uri
    }
  }
}
