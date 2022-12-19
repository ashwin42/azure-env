terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.7.24"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name = "RPA-FIN03-TradeAgreementAutomation-UAT"

  iam_assignments = {
    "Contributor" = {
      groups = [
        "NV Tools & Products Member",
      ],
    },
  }
}