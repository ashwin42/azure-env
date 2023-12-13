terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//user_assigned_identity?ref=v0.9.9"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//user_assigned_identity"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name = "nvinfra-acr-gh-actions"
  federated_identity_credentials = [
    {
      name     = "nvinfra-acr-gh-actions"
      issuer   = "https://token.actions.githubusercontent.com"
      subject  = "repo:northvolt/docker-techops:ref:refs/heads/main"
      audience = ["api://AzureADTokenExchange"]
    }
  ]
}
