terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//subscription?ref=v0.7.51"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//subscription"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  management_group = "Self Managed"
  iam_assignments = {
    "Contributor" = {
      service_principals = [
        "aviatrix_controller_app_prod",
      ],
    },
    "Reader" = {
      groups = [
        "Azure Subscriptions Reader Access",
      ],
    },
  }

  tags = {
    business-unit = "100 Digitalization AT - AB"
    department    = "100005 Digitalization Common - AB"
    cost-center   = "100005001 Digitalization Core - AB"
  }
}
