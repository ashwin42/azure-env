terraform {
  #source = "git::git@github.com:northvolt/tf-mod-azure.git//bootstrap_subscription?ref=v0.5.3"
  source = "../../../tf-mod-azure/bootstrap_subscription/"
}

include "account_vars" {
  path   = "../account.hcl"
  expose = true
}

inputs = {
  subscription_id = include.account_vars.locals.subscription_id
  name            = include.account_vars.locals.subscription_name
}
