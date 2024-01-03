terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//user_assigned_identity?ref=v0.10.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//user_assigned_identity"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "cluster" {
  config_path = "../../aks/cluster"
}

dependency "vault" {
  config_path = "../../../westeurope/global/vaults/secrets"
}

inputs = {
  resource_group_name = split("/", dependency.cluster.outputs.aks_id)[4]
  name                = "atlantis-identity"
  federated_identity_credentials = [
    {
      name     = "atlantis-identity"
      issuer   = dependency.cluster.outputs.oidc_issuer_url
      subject  = "system:serviceaccount:atlantis:atlantis"
      audience = ["api://AzureADTokenExchange"]
    }
  ]
  grant_consent = [
    {
      service_principal_name = "Microsoft Graph"
      type                   = "Application"
      claim_values = [
        "User.Read.All",
        "Group.ReadWrite.All",
        "Application.ReadWrite.OwnedBy",
      ]
    },
  ]
}
