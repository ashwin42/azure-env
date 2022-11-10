terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//action_group?ref=v0.7.6"
  #source = "../../../../../../../tf-mod-azure/action_group/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  action_group_name             = "techops-ag"
  action_group_short_name       = "techops"
  action_group_email_receivers  = [
    {
    name = "TechOps Team",
    email_address = "techops@northvolt.com",
    }
    ]
}

