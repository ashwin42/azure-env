terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//monitor_diagnostic_setting?ref=v0.5.3"
  #source = "../../../../../tf-mod-azure//monitor_diagnostic_setting/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name = "nv-d365-dev"
  retention_policy = [
    {
      enabled = "true",
      days    = "180"
    }
  ]

  log = [
    {
      category = "Administrative"
    },
    {
      category = "Alert"
    },
    {
      category = "Autoscale"
    },
    {
      category = "Policy"
    },
    {
      category = "Recommendation"
    },
    {
      category = "ResourceHealth"
    },
    {
      category = "Security"
    },
    {
      category = "ServiceHealth"
    },
  ]
}

