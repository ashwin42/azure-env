terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.10.13"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//storage"
}

dependency "subnet" {
  config_path = "../subnet"
}

dependency "rg" {
  config_path = "../resource_group"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  name                = "dwarndstorage"
  resource_group_name = dependency.rg.outputs.resource_group_name
  sftp_enabled        = true
  is_hns_enabled      = true

  data_lake_gen2_filesystems = [
    {
      group_name = "NV TechOps Role"
      name       = "dwarndstorage-dl"

      ace = [
        {
          group       = "Dwa RND Data Lake QC Storage"
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
              group       = "Dwa RND Data Lake QC Storage"
            },
            {
              group       = "Dwa RND Data Lake Storage Admin"
              permissions = "rwx"
              scope       = "access"
              type        = "group"
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
      name                 = "dwaqcdatalakeadmin"
      home_directory       = "dwarndstorage-dl/qc-testresults"
      ssh_password_enabled = true
      permission_scopes = [
        {
          resource_name = "dwarndstorage-dl"
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
      name                 = "dwaqcdatalakewriter"
      home_directory       = "dwarndstorage-dl/qc-testresults"
      ssh_password_enabled = true
      permission_scopes = [
        {
          resource_name = "dwarndstorage-dl"
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
      name                 = "dwarnddatalakeadmin"
      ssh_password_enabled = true
      permission_scopes = [
        {
          resource_name = "dwarndstorage-dl"
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

  private_endpoints = [
    {
      name      = "nv-dwa-rnd-pe"
      subnet_id = dependency.subnet.outputs.subnets["nv-dwa-rnd"].id
      private_service_connection = {
        name              = "nv-dwa-rnd-pec"
        subresource_names = ["dfs"]
      }
      private_dns_zone_group = {
        name                         = "nv-dwa-rnd-pec"
        dns_zone_resource_group_name = "core_network"
        dns_zone_name                = "privatelink.dfs.core.windows.net"
      }
    },
    {
      name      = "nv-dwa-rnd-blob-pe"
      subnet_id = dependency.subnet.outputs.subnets["nv-dwa-rnd"].id
      private_service_connection = {
        name              = "nv-dwa-rnd-blob-pec"
        subresource_names = ["blob"]
      }
      private_dns_zone_group = {
        name                         = "nv-dwa-rnd-blob-pec"
        dns_zone_resource_group_name = "core_network"
        dns_zone_name                = "privatelink.blob.core.windows.net"
      }
    }
  ]

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

