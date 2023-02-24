terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.2.35"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/storage"
}

dependency "global" {
  config_path = "../global"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix             = dependency.global.outputs.setup_prefix
  resource_group_name      = dependency.global.outputs.resource_group.name
  storage_account_name     = "nvpnesa"
  large_file_share_enabled = true
  skuname                  = "Standard_GRS"
  min_tls_version          = "TLS1_0"
  enable_ad_auth           = false

  containers_list = [
    { name = "nv-pne-ftp", access_type = "private" }
  ]

  lifecycles = [
    {
      rule                       = "movetocold"
      prefix_match               = null
      tier_to_cool_after_days    = 90
      tier_to_archive_after_days = null
      delete_after_days          = null
      snapshot_delete_after_days = 99999
    },
  ]

  network_rules = [
    {
      name           = "default_rule"
      bypass         = ["AzureServices"]
      default_action = "Deny"
      subnet_ids     = [dependency.global.outputs.subnet["nv-pne-subnet-10.44.5.32"].id]
      ip_rules = [
        "185.113.97.247",
        "213.50.54.196",
        "81.233.195.87",
        "94.254.76.224",
      ]
    },
  ]
}

