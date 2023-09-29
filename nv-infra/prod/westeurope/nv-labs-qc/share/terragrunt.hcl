terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.8.2"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//storage"
}

dependency "subnet" {
  config_path = "../subnet"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name                         = "rndqcstorage"
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

  private_endpoints = {
    nv-labs-rndqcstorage-file-pe = {
      subnet_id = dependency.subnet.outputs.subnet["nv-labs-qc-subnet-10.46.2.32_28"].id
      private_service_connection = {
        name              = "nv-labs-rndqcstorage-file-pec"
        subresource_names = ["file"]
      }
      private_dns_zone_group = {
        name                         = "nv-labs-rndqcstorage-file-pec"
        dns_zone_resource_group_name = "nv_infra"
        dns_zone_name                = "privatelink.file.core.windows.net"
        dns_zone_subscription_id     = "11dd160f-0e01-4b4d-a7a0-59407e357777"

      }
    }
  }

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
