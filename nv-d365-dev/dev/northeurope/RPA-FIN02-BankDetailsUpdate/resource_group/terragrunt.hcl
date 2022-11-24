terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.7.16"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name = "RPA-FIN02-BankDetailsUpdate"
  iam_assignments = {
    "Contributor" = {
      "groups" = [
        "CostCenter 109035061 Tools & Products",
      ],
    },
    "Owner" = {
      "users" = [
        "vladimir.kosilko@northvolt.com",
      ],
    },
  }
}