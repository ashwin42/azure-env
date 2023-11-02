terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//subscription?ref=v0.7.33"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//subscription"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  management_group = "Managed"

  tags = {
    owner         = "techops@northvolt.com"
    business-unit = "109 Digitalization IT - AB"
    cost-center   = "109035060 TechOps"
    department    = "109035 Operations & Infrastructure - AB"
  }
}
