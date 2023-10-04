## 
## This is just a dummy-file for use in "/azure-env/.github/workflow/update-readme-subscription-workflow.yml"
##
## It seems we do not have api PUT permissions on this resource, most likely due to it being set up by CSP (ATEA?)
## These permissions are needed to set an alias for the subscription in order to import it into state.
##


terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//subscription?ref=v0.7.33"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//subscription"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  subscription_name = "Microsoft Azure (northvolt0): #1000880"
  management_group  = "Self Managed"

  tags = {
    owner         = "mikael.lindstrom@northvolt.com"
    business-unit = "109 Digitalization IT - AB"
    department    = "109036 Security - AB"
    cost-center   = "109036064 Security - AB"
  }
}
