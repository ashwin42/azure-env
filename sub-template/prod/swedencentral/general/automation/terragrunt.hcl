terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//automation?ref=v0.10.2"
  # source = "${dirname(get_repo_root())}/tf-mod-azure/automation"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name = include.root.locals.all_vars.automation_account_name
}

