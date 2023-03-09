terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.7.44"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/storage"
}

dependency "subnet" {
  config_path = "../../../../prod/westeurope/nv-ataccama/subnet"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name                  = "dlmasterdataataccamadev"
  is_hns_enabled        = true
  data_lake_owner_group = "NV TechOps Role"

  iam_assignments = {
    "Storage Account Contributor" = {
      groups = [
        "NV TechOps Consultants Member",
        "NV TechOps Role",
        "Ataccama - Datalake Admins Dev",
      ],
    },
    "Storage Blob Data Owner" = {
      groups = [
        "NV TechOps Role",
      ]
    }
    "Storage Blob Data Contributor" = {
      groups = [
        "NV TechOps Consultants Member",
        "Ataccama - Datalake Admins Dev",
      ]
      service_principals = [
        "nv-ataccama-synapse-ws-dev",
      ]
    },
  }

  data_lake_gen2_filesystems = [
    {
      name        = "dlmasterdataataccamadev-dl"
      owner_group = "NV TechOps Role"
      group_name  = "NV TechOps Role"
      ace = [
        {
          scope       = "default"
          type        = "group"
          permissions = "rwx"
        },
        {
          scope       = "default"
          type        = "group"
          group       = "Ataccama - Datalake Admins Dev"
          permissions = "rwx"
        },
        {
          scope             = "default"
          type              = "user"
          service_principal = "nv-ataccama-synapse-ws-dev"
          permissions       = "rwx"
        },
        {
          scope       = "access"
          type        = "group"
          group       = "Ataccama - Datalake Admins Dev"
          permissions = "rwx"
        },
        {
          scope             = "access"
          type              = "user"
          service_principal = "nv-ataccama-synapse-ws-dev"
          permissions       = "rwx"
        },
      ]

      paths = [
        {
          path = "ataccama-data"
        },
      ]
    },
  ]

  private_endpoints = {
    nv-ataccama-dev-pe = {
      subnet_id = dependency.subnet.outputs.subnet["nv-ataccama-subnet"].id
      private_service_connection = {
        name              = "nv-ataccama-dev-pec"
        subresource_names = ["dfs"]
      }
      private_dns_zone_group = {
        name                         = "nv-ataccama-dev-pec"
        dns_zone_resource_group_name = "core_network"
        dns_zone_name                = "privatelink.dfs.core.windows.net"
        dns_zone_subscription_id     = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"

      }
    }
    nv-ataccama-dev-blob-pe = {
      subnet_id = dependency.subnet.outputs.subnet["nv-ataccama-subnet"].id
      private_service_connection = {
        name              = "nv-ataccama-dev-blob-pec"
        subresource_names = ["blob"]
      }
      private_dns_zone_group = {
        name                         = "nv-ataccama-dev-blob-pec"
        dns_zone_resource_group_name = "core_network"
        dns_zone_name                = "privatelink.blob.core.windows.net"
        dns_zone_subscription_id     = "4312dfc3-8ec3-49c4-b95e-90a248341dd5"
      }
    }
  }

  lifecycles = [
    {
      base_blob = {
        tier_to_cool_after_days    = 7
        tier_to_archive_after_days = 180
      }
    }
  ]

  network_rules = {
    name                       = "default_rule"
    bypass                     = ["AzureServices"]
    default_action             = "Deny"
    virtual_network_subnet_ids = [dependency.subnet.outputs.subnet["nv-ataccama-subnet"].id, ]
    ip_rules = [
      "16.170.65.157",
      "13.49.218.90",
      "98.128.134.222",
      "13.50.139.136",
    ]
  }

}

