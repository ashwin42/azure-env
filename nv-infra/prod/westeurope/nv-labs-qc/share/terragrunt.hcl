terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.8.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//storage"
}

include {
  path = find_in_parent_folders()
}

<<<<<<< HEAD
inputs = {
  name                         = "rndqcstorage"
=======
dependency "rg" {
  config_path = "../resource_group"
}

inputs = {
  name                         = "rndqcstorage"
  recovery_vault_name          = "nv-labs-qc-rv"
  resource_group_name          = dependency.rg.outputs.resource_group_name
>>>>>>> f313e22ddc5e99e43d43ef1c74f304268a77c3f2
  register_with_recovery_vault = true
  azure_files_authentication = {
    directory_type = "AADDS"
  }

  file_shares = [
    {
      name           = "qc-chemical",
      quota          = 100,
      lock_resources = false,
      access_tier    = "Hot",
      backup_policies = [
        {
          name = "chemical-backup-policy"
          backup = {
            frequency = "Daily"
            time      = "23:00"
          }

          retention_daily = {
            count = 10
          }
        },
      ]
      iam_assignments = {
        "Storage File Data SMB Share Contributor" = {
          groups = [
            "R&D QC Chemical Contributor",
          ],
        },
      }
    },
    {
      name           = "qc-mechanical",
      quota          = 100,
      lock_resources = false,
      access_tier    = "Hot",
      backup_policies = [
        {
          name = "mechanical-backup-policy"
          backup = {
            frequency = "Daily"
            time      = "23:00"
          }

          retention_daily = {
            count = 10
          }
        },
      ]
      iam_assignments = {
        "Storage File Data SMB Share Contributor" = {
          groups = [
            "R&D QC Mechanical Contributor",
          ],
        },
      }
    }
  ]

  iam_assignments = {
    "Storage Account Contributor" = {
      groups = [
        "NV TechOps Role",
      ],
    },
    "Storage Blob Data Owner" = {
      groups = [
        "NV TechOps Role",
      ],
    },
  }
}
