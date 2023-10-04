terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//subscription?ref=v0.7.33"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//subscription"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  subscription_name = "NV-Sentinel-Log_Analytics"
  management_group  = "Self Managed"

  tags = {
    owner         = "mikael.lindstrom@northvolt.com"
    business-unit = "109 Digitalization IT - AB"
    department    = "109036 Security - AB"
    cost-center   = "109036064 Security - AB"
  }
}
