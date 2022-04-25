terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//action_group?ref=v0.3.02"
  #source = "../../../../../../tf-mod-azure/action_group/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix                  = "techops-monitoring"
  resource_group_name           = "techops-rg"
  action_group_name             = "techops-ag"
  action_group_short_name       = "techops"
  action_group_email_receivers  =  [
    {
      "name"          = "Mihajlo Manojlov"
      "email_address" = "mihajlo.manojlov@northvolt.com"
    },
    {
      "name"          = "Johannes Hedberg"
      "email_address" = "johannes.hedberg@northvolt.com"
    },
    {
      "name"          = "Johan Leirnes"
      "email_address" = "johan.leirnes@northvolt.com"
    },
  ]
}

