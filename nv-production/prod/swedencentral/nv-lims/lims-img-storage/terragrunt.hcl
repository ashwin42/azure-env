terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.9.4"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/storage"
}

dependency "subnet" {
  config_path = "../subnet"
}

dependency "rg" {
  config_path = "../resource_group"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name                = "nvlimsimgstorage"
  resource_group_name = dependency.rg.outputs.resource_group_name
  sftp_enabled        = true
  is_hns_enabled      = true

  data_lake_gen2_filesystems = [
    {
      group_name = "NV TechOps Role"
      name       = "nvlimsimgstorage-dl"

      ace = [
        {
          group       = "Labware Users"
          permissions = "rwx"
          scope       = "default"
          type        = "group"
        },
      ]
      iam_assignments = {
        "Storage Blob Data Owner" = {
          groups = [
            "NV TechOps Role",
          ],
        },
      }

      paths = [
        {
          path       = "qc-testresults"
          group_name = "NV TechOps Role"
          ace = [
            {
              permissions = "rwx"
              scope       = "default"
              type        = "group"
              group       = "Labware Users"
            },
          ]
        }
      ]
    }
  ]

  lifecycles = [
    {
      base_blob = {
        tier_to_archive_after_days = 1095
        delete_after_days          = 10950
      }
    }
  ]

  local_users = [
    {
      name                 = "nvlimsimgqcdatalakeadmin"
      home_directory       = "nvlimsimgstorage-dl/qc-testresults"
      ssh_password_enabled = true
      permission_scopes = [
        {
          resource_name = "nvlimsimgstorage-dl"
          service       = "blob"

          permissions = {
            create = true
            delete = true
            list   = true
            read   = true
            write  = true
          }
        },
      ]
    },
    {
      name                 = "nvlimsimgqcdatalakewriter"
      home_directory       = "nvlimsimgstorage-dl/qc-testresults"
      ssh_password_enabled = true
      permission_scopes = [
        {
          resource_name = "nvlimsimgstorage-dl"
          service       = "blob"

          permissions = {
            create = true
            delete = false
            list   = true
            read   = true
            write  = true
          }
        },
      ]
    },
    {
      name                 = "nvlimsimgdatalakeadmin"
      ssh_password_enabled = true
      permission_scopes = [
        {
          resource_name = "nvlimsimgstorage-dl"
          service       = "blob"

          permissions = {
            create = true
            delete = true
            list   = true
            read   = true
            write  = true
          }
        },
      ]
    },
  ]

  private_endpoints = {
    nv-lims-img-pe = {
      subnet_id = dependency.subnet.outputs.subnets["nv-lims-subnet-10.64.1.32_27"].id
      private_service_connection = {
        name              = "nv-lims-img-pec"
        subresource_names = ["dfs"]
      }
      private_dns_zone_group = {
        name                         = "nv-lims-img-pec"
        dns_zone_resource_group_name = "core_network"
        dns_zone_name                = "privatelink.dfs.core.windows.net"
        dns_zone_subscription_id     = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
      }
    }
    nv-lims-img-blob-pe = {
      subnet_id = dependency.subnet.outputs.subnets["nv-lims-subnet-10.64.1.32_27"].id
      private_service_connection = {
        name              = "nv-lims-img-blob-pec"
        subresource_names = ["blob"]
      }
      private_dns_zone_group = {
        name                         = "nv-lims-img-blob-pec"
        dns_zone_resource_group_name = "core_network"
        dns_zone_name                = "privatelink.blob.core.windows.net"
        dns_zone_subscription_id     = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
      }
    }
  }

  network_rules = {
    name           = "default_rule"
    bypass         = ["AzureServices"]
    default_action = "Deny"
    virtual_network_subnet_ids = [
      dependency.subnet.outputs.subnets["nv-lims-subnet-10.64.1.32_27"].id,
    ]
  }

  iam_assignments = {
    "Storage Account Contributor" = {
      groups = [
        "NV TechOps Role",
      ],
    },
  }
}
