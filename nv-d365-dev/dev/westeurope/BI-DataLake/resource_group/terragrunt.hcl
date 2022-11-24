terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.7.15"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name = "BI-DataLake"
  setup_prefix        = ""
  iam_assignments = {
    "Owner" = {
      "users" = [
        "lisa.andersson@northvolt.com",
        "henrik.miiro@northvolt.com",
        "c.sanjeet.saluja@northvolt.com",
        "Einar.Cardona@northvolt.com",
      ],
      "groups" = [
        "NV Power BI DB Access",
      ],
    },
    "Reader" = {
      "users" = [
        "samantha.transfeld@northvolt.com",
      ],
    },
    "Contributor" = {
      "users" = [
        "c.jorgen.hasselgren@northvolt.com",
      ],
    },
  }
}