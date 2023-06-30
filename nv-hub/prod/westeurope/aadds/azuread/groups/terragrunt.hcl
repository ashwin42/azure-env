terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//groups?ref=v1.3.4"
  #source = "../../../../../../tf-mod-azuread/groups/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  groups = [
    {
      display_name     = "AAD DC Administrators"
      description      = "AADDS administrative group. Members of this group are granted administrative permissions on VMs that are domain-joined to the managed domain. On domain-joined VMs, this group is added to the local administrators group. Members of this group can also use Remote Desktop to connect remotely to domain-joined VMs."
      security_enabled = true
      member_users     = []
    },
  ]
}

