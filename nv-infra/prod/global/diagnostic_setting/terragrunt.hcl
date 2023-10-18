terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//monitor_diagnostic_setting?ref=v0.7.32"
  #source = "../../../../../tf-mod-azure//monitor_diagnostic_setting/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name = "nv_gen_infra"
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

