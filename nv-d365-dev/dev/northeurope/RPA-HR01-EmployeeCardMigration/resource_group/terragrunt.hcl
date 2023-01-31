terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.7.16"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  iam_assignments = {
    "EventGrid Contributor" = {
      "service_principals" = [
        "TalentEmployeeChangesEventGridTopic",
      ],
    },
    "Contributor" = {
      "groups" = [
        "CostCenter 109035061 Tools & Products",
      ],
    },
    "Logic App Contributor" = {
      "users" = [
        "akshay.kumar@northvolt.com",
      ],
    },
    "Owner" = {
      "users" = [
        "vladimir.kosilko@northvolt.com",
      ],
    },
    "Reader" = {
      "users" = [
        "c.sonia.joshi@northvolt.com",
      ],
    },
  }
}
