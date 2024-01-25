terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.10.14"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/storage"
}
dependency "vnet" {
  config_path = "../../subnet"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  name = "${replace("${basename(dirname(dirname(get_terragrunt_dir())))}${basename(get_terragrunt_dir())}stg", "-", "")}"

  file_shares = [
    {
      name  = "results",
      quota = 100
    },
  ]

  private_endpoints = [
    {
      name      = "nv-lims-storage-pe"
      subnet_id = dependency.vnet.outputs.subnets["nv-lims-subnet-10.64.1.32_27"].id
      ip_configuration = [
        {
          private_ip_address = "10.64.1.62"
          subresource_name   = "file"
        },
      ]
      private_service_connection = {
        subresource_names = ["file"]
      }
      private_dns_zone_group = {
        name                         = "nv-lims-storage-pe-zg"
        dns_zone_name                = "privatelink.file.core.windows.net"
        dns_zone_resource_group_name = "nv_infra"
      }
    }
  ]

  azure_files_authentication = {
    directory_type = "AADDS"
  }

  network_rules = {
    default_action = "Allow"
  }

  iam_assignments = {
    "Storage File Data SMB Share Elevated Contributor" = {
      groups = [
        "NV TechOps Role",
      ],
    },
    "Storage File Data SMB Share Contributor" = {
      groups = [
        "Labware LIMS Developers",
        "Labware Users - Ett",
        "Labware Users - Labs",
      ],
    },
    "Reader and Data Access" = {
      groups = [
        "Labware LIMS Developers",
        "Labware Users - Labs",
        "Labware Users - Ett",
      ],
    },
  }
}
