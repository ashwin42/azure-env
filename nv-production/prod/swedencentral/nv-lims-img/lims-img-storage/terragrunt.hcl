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
  name            = basename(get_terragrunt_dir())
  resource_group_name = dependency.rg.outputs.resource_group_name
  sftp_enabled        = true
  is_hns_enabled      = true

  data_lake_gen2_filesystems = [
    {
      group_name = "NV TechOps Role"
      name          = basename(get_terragrunt_dir()).¨-dl¨ 

      ace = [
        {
          group       = "LIMS Img Storage"
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
          path       = "lims-img"
          group_name = "NV TechOps Role"
          ace = [
            {
              permissions = "rwx"
              scope       = "default"
              type        = "group"
              group       = "LIMS Img Storage"
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
        delete_after_days          = 4380
      }
    }
  ]

  local_users = [
    {
      name                 = "lims-img-admin"
      home_directory       = "lims-img-storage-dl/lims-img"
      ssh_password_enabled = true
      permission_scopes = [
        {
          resource_name = "lims-img-storage-dl"
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
      name                 = "limsimg writer"
      home_directory       = "lims-img-storage-dl/lims-img"
      ssh_password_enabled = true
      permission_scopes = [
        {
          resource_name = "lims-img-storage-dl"
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
      name                 = "limsimgadmin"
      ssh_password_enabled = true
      permission_scopes = [
        {
          resource_name = "lims-img-storage-dl"
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
    nv-dwa-rnd-pe = {
      subnet_id = dependency.subnet.outputs.subnets["nv-dwa-rnd"].id
      private_service_connection = {
        name              = "nv-dwa-rnd-pec"
        subresource_names = ["dfs"]
      }
      private_dns_zone_group = {
        name                         = "nv-dwa-rnd-pec"
        dns_zone_resource_group_name = "core_network"
        dns_zone_name                = "privatelink.dfs.core.windows.net"
        dns_zone_subscription_id     = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
      }
    }
    nv-dwa-rnd-blob-pe = {
      subnet_id = dependency.subnet.outputs.subnets["nv-dwa-rnd"].id
      private_service_connection = {
        name              = "nv-dwa-rnd-blob-pec"
        subresource_names = ["blob"]
      }
      private_dns_zone_group = {
        name                         = "nv-dwa-rnd-blob-pec"
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
      dependency.subnet.outputs.subnets["nv-dwa-rnd"].id,
    ]
    ip_rules = [
      "81.233.195.87",
      "213.50.54.196"
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

