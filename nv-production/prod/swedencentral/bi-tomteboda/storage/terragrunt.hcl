terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.7.10"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/storage/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name                              = replace(include.root.locals.all_vars.setup_prefix, "-", "")
  large_file_share_enabled          = false
  skuname                           = "Standard_LRS"
  infrastructure_encryption_enabled = true

  network_rules = {
    name           = "default_rule"
    default_action = "Allow"
  },

  iam_assignments = {
    Reader = {
      groups = [
        "NV Tomteboda Prod Data",
      ],
    },
    "Storage Account Contributor" = {
      groups = [
        "NV Tomteboda Prod Data",
      ],
      service_principals = [
        "Tomteboda Datalake"
      ],
    },
    "Storage Blob Data Owner" = {
      groups = [
        "NV Tomteboda Prod Data",
      ],
    },
  }
}
