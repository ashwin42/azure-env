terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.7.16"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name = "BI-DataLake-PreProd"
  iam_assignments = {
    "Owner" = {
      "users" = [
        "lisa.andersson@northvolt.com",
        "asma.komal@northvolt.com",
        "henrik.miiro@northvolt.com",
      ],
      "groups" = [
        "NV Power BI DB Access",
      ],
    },
    "Contributor" = {
      "users" = [
        "c.jorgen.hasselgren@northvolt.com",
      ],
    },
    "Reader" = {
      "users" = [
        "magnus.soderholtz@northvolt.com",
      ],
    },
  }
}