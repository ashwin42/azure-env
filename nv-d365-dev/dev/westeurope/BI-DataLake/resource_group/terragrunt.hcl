terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//resource_group?ref=v0.7.16"
}

include "root" {
  expose = true
  path   = find_in_parent_folders()
}

inputs = {
  resource_group_name = include.root.locals.all_vars.resource_group_name
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