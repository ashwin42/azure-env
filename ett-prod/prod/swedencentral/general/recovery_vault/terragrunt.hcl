terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//recovery_vault?ref=v0.9.4"
  #source = "../../../../../../tf-mod-azure/recovery_vault/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  recovery_vault_name = "${include.root.inputs.subscription_name}-swc-rv"
}

