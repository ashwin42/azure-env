terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//dns?ref=v0.10.9"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//dns/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  dns_zones = [
    {
      name                                = include.root.inputs.dns_domain
      delegate                            = true
      parent_dns_zone_name                = include.root.inputs.dns_domain_parent
      parent_dns_zone_resource_group_name = include.root.inputs.dns_domain_parent_resource_group_name

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
