terraform {
  source = "github.com/northvolt/tf-mod-azure//resource_group?ref=v0.8.6"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/resource_group/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  iam_assignments = {
    "Owner" = {
      groups = [
        "NV TechOps Role",
      ],
    },
  }
}

