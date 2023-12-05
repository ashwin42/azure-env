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
  name                = "labsqcstorage"
  resource_group_name = dependency.rg.outputs.resource_group_name
  sftp_enabled        = true
  is_hns_enabled      = true

  data_lake_gen2_filesystems = [
    {
      group_name = "NV TechOps Role"
      name       = "labsqcstorage-dl"

      ace = [
        {
          group       = "Labs QC Datalake Admin AP"
          permissions = "rwx"
          scope       = "default"
          type        = "group"
        },
      ]
    }
  ]

  lifecycles = [
    {
      base_blob = {
        tier_to_archive_after_days = 100
        delete_after_days          = 5375
      }
    }
  ]

  private_endpoints = {
    nv-labs-qcstorage-pe = {
      subnet_id = dependency.subnet.outputs.subnets["nv-labs-qc-subnet-10.46.2.32_28"].id
      private_service_connection = {
        name              = "nv-labs-qcstorage-pec"
        subresource_names = ["dfs"]
      }
      private_dns_zone_group = {
        name                         = "nv-labs-qcstorage-pec"
        dns_zone_resource_group_name = "core_network"
        dns_zone_name                = "privatelink.dfs.core.windows.net"
        dns_zone_subscription_id     = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
      }
    }
    nv-labs-qcstorage-blob-pe = {
      subnet_id = dependency.subnet.outputs.subnets["nv-labs-qc-subnet-10.46.2.32_28"].id
      private_service_connection = {
        name              = "nv-labs-qcstorage-blob-pec"
        subresource_names = ["blob"]
      }
      private_dns_zone_group = {
        name                         = "nv-labs-qcstorage-blob-pec"
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
      dependency.subnet.outputs.subnets["nv-labs-qc-subnet-10.46.2.32_28"].id,
    ]
    ip_rules = [
      "213.50.54.196",
      "81.233.195.87",
    ]
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

  local_users = [
    {
      name                 = "labsqcdatalakeadmin"
      home_directory       = "labsqcstorage-dl/qc-testresults"
      ssh_password_enabled = true
      permission_scopes = [
        {
          resource_name = "labsqcstorage-dl"
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
      name                 = "labsqcdatalakewriter"
      home_directory       = "labsqcstorage-dl/qc-testresults"
      ssh_password_enabled = true
      permission_scopes = [
        {
          resource_name = "labsqcstorage-dl"
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
  ]
}

