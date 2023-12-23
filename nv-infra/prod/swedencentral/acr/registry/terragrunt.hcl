terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//acr?ref=v0.9.9"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//acr"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name                          = "nvinfra"
  resource_group_name           = "infra-aks-rg"
  sku                           = "Standard"
  export_policy_enabled         = true
  public_network_access_enabled = true
  iam_assignments = {
    AcrPush = {
      service_principals = [
        "nvinfra-acr-gh-actions",
      ],
    }
  }
}
