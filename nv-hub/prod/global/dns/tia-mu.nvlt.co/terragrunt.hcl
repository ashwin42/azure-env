terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//dns?ref=v0.6.13"
  #source = "../../../../../../tf-mod-azure//dns/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  dns_zones = [
    {
      name                = basename(get_terragrunt_dir())
      resource_group_name = "core_network"
    },
  ]
}
