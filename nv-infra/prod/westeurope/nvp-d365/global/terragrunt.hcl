terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//global?ref=v0.2.13"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix  = "nvp-d365"
  address_space = ["10.44.5.216/29"]
  #dns_servers               = [ "10.40.250.5", "10.40.250.4" ]
  create_recovery_vault = false
  subnets = [
    {
      name             = "nvp-d365-subnet"
      address_prefixes = ["10.44.5.216/29"]
    },
  ]
}
