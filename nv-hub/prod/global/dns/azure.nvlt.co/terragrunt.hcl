terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//dns?ref=v0.7.54"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//dns/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  dns_zones = [
    {
      name                = basename(get_terragrunt_dir())
      resource_group_name = "core_network"
      records = [
        {
          name    = "pqms-ett"
          records = ["10.64.1.149"]
          ttl     = 300
        },
        {
          # fix module for automatic delegation of subdomain
          name = "infra"
          type = "ns"
          ttl  = 300
          records = [
            "ns1-36.azure-dns.com.",
            "ns2-36.azure-dns.net.",
            "ns3-36.azure-dns.org.",
            "ns4-36.azure-dns.info."
          ]
        }
      ]

      iam_assignments = {
        "DNS Zone Contributor" = {
          service_principals = [
            "Win-Acme Certificate Manager"
          ]
        }
      }
    }
  ]
}
