terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.7.16"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  iam_assignments = {
    "Reader" = {
      "service_principals" = [
        "Power BI Service",
      ],
    },
    "Owner" = {
      "users" = [
        "c.sanjeet.saluja@northvolt.com",
      ],
    },
  }
}