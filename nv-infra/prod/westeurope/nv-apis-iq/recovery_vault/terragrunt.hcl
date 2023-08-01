terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//recovery_vault?ref=v0.7.61"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/recovery_vault/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
}

