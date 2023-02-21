terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.7.35"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//policy/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  management_group_name = "Self Managed"
  management_group_policy_assignment = [
    {
      name                 = "tag_sub_inheritance_cc"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/40df99da-1232-49b1-a39a-6da8d878f469"
      display_name         = "Tagging Strategy: cost-center inheritance (self managed subs)"
      description          = "Tag cost-center will be inherited from subscription for resources in management group Self Managed"
      location             = "swedencentral"
      enforce              = true
      parameters           = file("parameter_cost_center.json")
      identity = [
        {
          type = "SystemAssigned"
        },
      ]
    },
    {
      name                 = "tag_sub_inheritance_bu"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/40df99da-1232-49b1-a39a-6da8d878f469"
      display_name         = "Tagging Strategy: business-unit inheritance (self managed subs)"
      description          = "Tag business-unit will be inherited from subscription for resources in management group Self Managed"
      location             = "swedencentral"
      enforce              = true
      parameters           = file("parameter_business-unit.json")
      identity = [
        {
          type = "SystemAssigned"
        },
      ]
    },
    {
      name                 = "tag_sub_inheritance_dep"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/40df99da-1232-49b1-a39a-6da8d878f469"
      display_name         = "Tagging Strategy: department inheritance (self managed subs)"
      description          = "Tag department will be inherited from subscription for resources in management group Self Managed"
      location             = "swedencentral"
      enforce              = true
      parameters           = file("parameter_department.json")
      identity = [
        {
          type = "SystemAssigned"
        },
      ]
    },
  ]
}

