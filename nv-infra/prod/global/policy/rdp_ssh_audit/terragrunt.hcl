terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.6.9"
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
      display_name        = "NSGs allowing inbound traffic on 3389 from Any or Internet"
      management_group_id = "/providers/Microsoft.Management/managementGroups/706c5db9-5278-483b-b622-70084f823a12"
      parameters          = file("definition_parameters.json")
      policy_rule         = file("definition_policy_rule_rdp.json")
      policy_type         = "Custom"
    },
    {
      name                = "policy-ssh-open-to-internet",
      display_name        = "NSGs allowing inbound traffic on 22 from Any or Internet"
      management_group_id = "/providers/Microsoft.Management/managementGroups/706c5db9-5278-483b-b622-70084f823a12"
      parameters          = file("definition_parameters.json")
      policy_rule         = file("definition_policy_rule_ssh.json")
      policy_type         = "Custom"
    }
  ]

  #Management Group Assignments
  management_group_policy_assignment = [
    {
      name                 = "de8fb31206534142944c9129",
      management_group_id  = "/providers/Microsoft.Management/managementGroups/706c5db9-5278-483b-b622-70084f823a12"
      policy_definition_id = "/providers/Microsoft.Management/managementGroups/706c5db9-5278-483b-b622-70084f823a12/providers/Microsoft.Authorization/policyDefinitions/1dce653f-21de-42dc-84f5-689189d6b457"
      description          = "Denies the creation of Network Security Rules that allows RDP access from Internet/Any",
      display_name         = "Deny NSG allowing inbound traffic on 3389 from internet",
      enforce              = true,
      parameters           = file("deny_assignment_parameters.json")
      non_compliance_message = [
        {
          content         = "Please use Azure Bastion or VPN instead",
        },
      ]
    },
    {
      name                 = "deny-internet-ssh-policy",
      management_group_id  = "/providers/Microsoft.Management/managementGroups/706c5db9-5278-483b-b622-70084f823a12"
      policy_definition_id = "/providers/Microsoft.Management/managementGroups/706c5db9-5278-483b-b622-70084f823a12/providers/Microsoft.Authorization/policyDefinitions/policy-ssh-open-to-internet"
      description          = "Denies the creation of Network Security Rules that allows SSH access from Internet/Any",
      display_name         = "Deny NSG allowing inbound traffic on 22 from internet",
      enforce              = true,
      parameters           = file("deny_assignment_parameters.json")
      non_compliance_message = [
        {
          content         = "Please use Azure Bastion or VPN instead",
        },
      ]      
    },    
  ]
}

