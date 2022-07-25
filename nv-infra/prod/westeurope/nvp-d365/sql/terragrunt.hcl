terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//sql?ref=v0.2.14"
  #source = "../../../../tf-mod-azure/sql"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

inputs = {
  resource_group_name = dependency.global.outputs.resource_group.name
  setup_prefix        = dependency.global.outputs.setup_prefix
  subnet_id           = dependency.global.outputs.subnet.nvp-d365-subnet.id
  key_vault_name      = "nv-infra-core"
  key_vault_rg        = "nv-infra-core"
  #create_private_endpoint = true
  databases = [
    {
      name = "nvp-d365"
    },
  ]
  custom_rules = [
    {
      name      = "AllowLocalSubnet"
      subnet_id = dependency.global.outputs.subnet.nvp-d365-subnet.id
    },
    {
      name             = "NVP Jeden"
      start_ip_address = "188.252.120.146"
    },
    {
      name             = "NVP Jeden Backup fiber"
      start_ip_address = "85.219.139.46"
    },
    {
      name             = "NV Labs"
      start_ip_address = "213.50.54.193"
      end_ip_address   = "213.50.54.206"
    },
    {
      name             = "NV Telia"
      start_ip_address = "62.20.23.1"
      end_ip_address   = "62.20.23.14"
    },
  ]
}
