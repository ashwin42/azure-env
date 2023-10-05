terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//subscription?ref=v0.7.35"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//subscription"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  management_group = "Self Managed"
  iam_assignments = {
    "Billing Reader" = {
      groups = [
        "NV Tools & Products Engineering Manager",
        "NV Tools & Products Leads",
      ],
    },
    "Reader" = {
      groups = [
        "NV Tools & Products Member",
      ],
    },
  }

  tags = {
    owner         = "galen.lanphier@northvolt.com"
    business-unit = "109 Digitalization IT - AB"
    department    = "109035 Operations & Infrastructure - AB"
    cost-center   = "109035061 Tools & Products"
  }
}
