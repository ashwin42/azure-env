terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//aks//external_secret?ref=v0.9.9"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/aks//external_secret"
}

dependency "cluster" {
  config_path = "../../aks/cluster"
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
  helm_aks_resource_group_name = split("/", dependency.cluster.outputs.aks_id)[4]

  namespace        = "atlantis"
  create_namespace = true

  key_vault_name = dependency.vault.outputs.azurerm_key_vault.name
  key_vault_rg   = dependency.vault.outputs.azurerm_key_vault.resource_group_name

  external_secrets = [
    {
      name             = "atlantis-github"
      refresh_interval = "24h"
      target = {
        name = "atlantis-gh-app"
      }
      secret_data = [
        {
          key        = "key.pem"
          remote_ref = "atlantis-gh-app-key"
        },
        {
          key        = "github_secret"
          remote_ref = "atlantis-gh-app-webhook-secret"
        }
      ]
    },
    {
      name             = "atlantis-basic-auth"
      refresh_interval = "24h"
      target = {
        name = "atlantis-basic-auth"
      }
      secret_data = [
        {
          key           = "username"
          remote_ref    = "atlantis-basic-auth-username"
          create_secret = true
          secret_value  = "atlantis"
        },
        {
          key           = "password"
          remote_ref    = "atlantis-basic-auth-password"
          create_secret = true
        }
      ]
    }
  ]
}
