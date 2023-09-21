terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//management_group?ref=v0.7.39"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/management_group/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name         = "706c5db9-5278-483b-b622-70084f823a12"
  display_name = "Tenant Root Group"
  iam_assignments = {
    "Lucidscale import" = {
      service_principals = [
        "LucidChart Cloud Insights Access",
      ],
    },
    "Reader" = {
      groups = [
        "NV TechOps Role",
      ]
      users = [
        "alex.ga@northvolt.com",
        "mihajlo.ga@northvolt.com",
        "andreas.axelsson.admin@northvolt.com",
        "johannes.ga@northvolt.com",
      ],
    },
  }
}

