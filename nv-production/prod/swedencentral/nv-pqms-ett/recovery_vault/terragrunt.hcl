terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//recovery_vault?ref=v0.7.50"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/tf-mod-azure/recovery_vault/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  cross_region_restore_enabled = true
}

