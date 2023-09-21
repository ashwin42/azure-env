terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//maintenance_configuration?ref=v0.8.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//maintenance_configuration/"
}

include {
  path = find_in_parent_folders()
}

locals {
  name = basename(get_original_terragrunt_dir())
}

inputs = {
  name                     = local.name
  in_guest_user_patch_mode = "User"

  install_patches = {
    reboot = "Never"
    windows = {
      classifications_to_include = ["Critical", "Security"]
    }
    linux = {
      classifications_to_include = ["Critical", "Security"]
    }
  }

  window = {
    start_date_time = "2023-08-23 09:00"
    recur_every     = "1Week Wednesday"
    duration        = "02:00"
  }
}
