terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//wvd?ref=v0.7.13"
  #source = "${dirname(get_repo_root())}/tf-mod-azure/wvd/"
}
include {
  path = find_in_parent_folders()
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common-wvd.hcl"))
  name   = basename(dirname(dirname(get_terragrunt_dir())))
}

inputs = {
  workspaces = [merge(local.common.inputs.workspaces[0],
    )
  ]
  host_pools = [
    merge(local.common.inputs.host_pools[0],
      {
        name          = "${local.name}-02-hp"
        friendly_name = "Labware LIMS Ett"
        description   = "Remote desktop to LIMS at Ett"
      }
    ),
    merge(local.common.inputs.host_pools[0],
      {
        name          = "${local.name}-03-hp"
        friendly_name = "Labware LIMS Labs"
        description   = "Remote desktop to LIMS at Ett"
      }
    ),
    merge(local.common.inputs.host_pools[0],
      {
        name          = "${local.name}-04-hp"
        friendly_name = "Labware LIMS Dev"
        description   = "Remote desktop to administer Lims"
      }
    ),
    merge(local.common.inputs.host_pools[0],
      {
        name          = "${local.name}-05-hp"
        friendly_name = "Labware LIMS BG tasks"
        description   = "Remote desktop to administer Lims bg tasks"
      }
    ),
  ]
  application_groups = [
    merge(local.common.inputs.application_groups[0],
      {
        name                         = "${local.name}-02-ap"
        host_pool_name               = "${local.name}-02-hp"
        friendly_name                = "LIMS Ett VM"
        default_desktop_display_name = "LIMS Ett VM"
        description                  = "Remote desktop to LIMS at Ett"
        assign_groups = [
          "NV TechOps Role",
          "Labware LIMS Developers",
          "Labware Users - Ett",
        ]
      }
    ),
    merge(local.common.inputs.application_groups[0],
      {
        name                         = "${local.name}-03-ap"
        host_pool_name               = "${local.name}-03-hp"
        friendly_name                = "LIMS Labs VM"
        default_desktop_display_name = "LIMS Labs VM"
        description                  = "Remote desktop to LIMS at Labs"
        assign_groups = [
          "NV TechOps Role",
          "Labware LIMS Developers",
          "Labware Users - Labs",
        ]
      }
    ),
    merge(local.common.inputs.application_groups[0],
      {
        name                         = "${local.name}-04-ap"
        host_pool_name               = "${local.name}-04-hp"
        friendly_name                = "LIMS Dev VM"
        default_desktop_display_name = "LIMS Dev VM"
        description                  = "Remote desktop to LIMS dev VM"
        assign_groups = [
          "NV TechOps Role",
          "Labware LIMS Developers",
        ]
      }
    ),
    merge(local.common.inputs.application_groups[0],
      {
        name                         = "${local.name}-05-ag"
        host_pool_name               = "${local.name}-05-hp"
        friendly_name                = "LIMS BG VM"
        default_desktop_display_name = "LIMS BG VM"
        description                  = "Remote desktop to LIMS bg VM"
        assign_groups = [
          "NV TechOps Role",
          "Labware LIMS Developers",
        ]
      }
    ),
  ]
}
