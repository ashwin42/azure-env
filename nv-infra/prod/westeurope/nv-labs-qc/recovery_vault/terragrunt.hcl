terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//recovery_vault?ref=v0.8.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//recovery_vault"
}

include {
  path = find_in_parent_folders()
}

inputs = {
<<<<<<< HEAD
=======
  resource_group_name = "nv-labs-qc"
>>>>>>> f313e22ddc5e99e43d43ef1c74f304268a77c3f2
}


