terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//recovery_vault?ref=v0.3.0"
  #source = "../../../../../../tf-mod-azure/recovery_vault/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
}

