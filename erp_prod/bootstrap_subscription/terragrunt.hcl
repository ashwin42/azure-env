terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//bootstrap_subscription?ref=v0.5.3"
  #source = "../../../tf-mod-azure/bootstrap_subscription/"
}

inputs = {
  subscription_id = "810a32ab-57c8-430a-a3ba-83c5ad49e012"
  name            = "ERP_Prod"
}
