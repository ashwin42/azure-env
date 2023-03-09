terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//storage?ref=v0.7.12"
  #source = "../../../../../../tf-mod-azure/storage"
}
dependency "vnet" {
  config_path = "../../subnet"
}

include {
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
  private_endpoints = {
    "nv-lims-storage-pe" = {
      subnet_id = dependency.vnet.outputs.subnet["nv-lims-subnet-10.64.1.32_27"].id
      ip_configuration = {
        private_ip_address = "10.64.1.62"
        subresource_name   = "file"
      }
      private_dns_zone_group = {
        name                         = "nv-lims-storage-pe-zg"
        dns_zone_name                = "privatelink.file.core.windows.net"
        dns_zone_resource_group_name = "nv_infra"
        dns_zone_subscription_id     = "11dd160f-0e01-4b4d-a7a0-59407e357777"
        # dns_record_name            = "<dns_record_name>"
      }
      private_service_connection = {
        subresource_names = ["file"]
      }
    }
  }
  azure_files_authentication = {
    directory_type = "AADDS"
  }
  network_rules = [
    {
      default_action = "Deny"
    },
  ]
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
