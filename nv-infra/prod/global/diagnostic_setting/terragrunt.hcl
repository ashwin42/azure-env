terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//monitor_diagnostic_setting?ref=v0.5.2"
  #source = "../../../../../tf-mod-azure//monitor_diagnostic_setting/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name = "nv_gen_infra"
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

