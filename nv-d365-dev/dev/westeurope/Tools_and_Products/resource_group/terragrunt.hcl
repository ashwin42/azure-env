terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.7.16"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  iam_assignments = {
    "Owner" = {
      "service_principals" = [
        "TP Github Actions",
      ],
      "groups" = [
        "CostCenter 109035061 Tools & Products",
      ],
    },
    "Contributor" = {
      "groups" = [
        "CostCenter 109035061 Tools & Products",
      ],
      "service_principals" = [
        "UIpathAzureServicePrincipal",
        "GitHub Integration",
      ],
    },
    "Key Vault Administrator" = {
      "groups" = [
        "CostCenter 109035061 Tools & Products",
        "NV TechOps Lead Role",
      ],
    },
    "Virtual Machine Administrator Login" = {
      "groups" = [
        "CostCenter 109035061 Tools & Products",
      ],
      "users" = [
        "sa-tplogicappuser@northvolt.com",
        "sa-uipath.mailer@northvolt.com",
      ],
    },
    "Billing Reader" = {
      "users" = [
        "ermal@northvolt.com",
      ],
    },
    "Monitoring Metrics Publisher" = {
      "service_principals" = [
        "IT-Ticket-Label-Prediction",
        "IT-Ticket-Label-Prediction-Identity",
      ],
    },
  }
}
