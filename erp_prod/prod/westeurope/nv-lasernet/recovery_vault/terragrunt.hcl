terraform {
  source = "github.com/northvolt/tf-mod-azure//recovery_vault?ref=v0.8.6"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/recovery_vault/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
}

