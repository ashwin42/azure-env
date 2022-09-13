terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.4.0"
  #source = "../../../../../../tf-mod-azure//policy/"
}

include {
  path = find_in_parent_folders()
}

inputs = {

  #Policy Definitions
  policy_definition = [
    {
      name                = "1dce653f-21de-42dc-84f5-689189d6b457",
      display_name        = "NSGs allowing inbound traffic from Any or Internet"
      management_group_id = "/providers/Microsoft.Management/managementGroups/706c5db9-5278-483b-b622-70084f823a12"
      parameters          = file("definition_parameters.json")
      policy_rule         = file("definition_policy_rule.json")
      policy_type         = "Custom"
    }
  ]

  #Management Group Assignments
  management_group_policy_assignment = [
    {
      name                 = "de8fb31206534142944c9129",
      management_group_id  = "/providers/Microsoft.Management/managementGroups/706c5db9-5278-483b-b622-70084f823a12"
      policy_definition_id = "/providers/Microsoft.Management/managementGroups/706c5db9-5278-483b-b622-70084f823a12/providers/Microsoft.Authorization/policyDefinitions/1dce653f-21de-42dc-84f5-689189d6b457"
      description          = "Denies the creation of Network Security Rules that allows RDP or SSH access from Internet/Any",
      display_name         = "Deny NSG allowing inbound traffic from internet",
      enforce              = true,
      parameters           = file("deny_assignment_parameters.json")
    },
  ]
}

