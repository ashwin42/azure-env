terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//dns?ref=v0.7.54"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//dns/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  dns_zones = [
    {
      name                = basename(get_terragrunt_dir())
      resource_group_name = "core_network"

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
