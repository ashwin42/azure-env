terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.7.25"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/storage"
}

dependency "subnet" {
  config_path = "../subnet"
}

dependency "rg" {
  config_path = "../resource_group"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name                = "dwarndstorage"
  resource_group_name = dependency.rg.outputs.resource_group_name
  subnet_id           = dependency.subnet.outputs.subnet["nv-dwa-rnd"].id

  private_endpoints = {
    nv-dwa-rnd-pe = {
      subnet_id = dependency.subnet.outputs.subnet["nv-dwa-rnd"].id
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
      subnet_id = dependency.subnet.outputs.subnet["nv-dwa-rnd"].id
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

  sftp_enabled          = true
  is_hns_enabled        = true
  data_lake_owner_group = "NV TechOps Role"
  data_lake_ace = [
    {
      scope       = "default"
      type        = "group"
      group       = "Dwa RND Data Lake Storage Admin"
      permissions = "rwx"
    }
  ]

  data_lake_path = [
    {
      path = "qc-testresults"
      ace = [
        {
          scope       = "default"
          type        = "group"
          group       = "Dwa RND Data Lake QC Storage"
          permissions = "rwx"
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

  network_rules = {
    name           = "default_rule"
    bypass         = ["AzureServices"]
    default_action = "Deny"
    virtual_network_subnet_ids = [
      dependency.subnet.outputs.subnet["nv-dwa-rnd"].id,
    ]
    ip_rules = [
      "81.233.195.87",
    ]
  }

  iam_assignments = {
    "Storage Account Contributor" = {
      groups = [
        "NV TechOps Role",
      ],
    },
    "Storage Blob Data Contributor" = {
      groups = [
        "NV TechOps Role",
      ],
    },
  }
}

