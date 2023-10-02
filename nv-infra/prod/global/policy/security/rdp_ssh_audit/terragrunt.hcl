terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//policy?ref=v0.7.55"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//policy/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  policy_definitions = [
    {
      name                          = "policy-rdp-open-to-internet",
      display_name                  = "NSGs allowing inbound traffic on 3389 from Any or Internet"
      management_group_display_name = "NV Root"
      parameters                    = file("definition_parameters.json")
      policy_rule                   = file("definition_policy_rule_rdp.json")
      policy_type                   = "Custom"
      mode                          = "All"
    },
    {
      name                          = "policy-ssh-open-to-internet",
      display_name                  = "NSGs allowing inbound traffic on 22 from Any or Internet"
      management_group_display_name = "NV Root"
      parameters                    = file("definition_parameters.json")
      policy_rule                   = file("definition_policy_rule_ssh.json")
      policy_type                   = "Custom"
      mode                          = "All"
    }
  ]

  management_group_policy_assignments = [
    {
      name                          = "deny-internet-rdp-policy",
      policy_definition_id          = "/providers/Microsoft.Management/managementGroups/nv_root/providers/Microsoft.Authorization/policyDefinitions/policy-rdp-open-to-internet"
      description                   = "Denies the creation of Network Security Rules that allows RDP access from Internet/Any",
      display_name                  = "Deny NSG allowing inbound traffic on 3389 from internet",
      management_group_display_name = "NV Root"
      enforce                       = true,
      parameters                    = file("deny_assignment_parameters.json")
      non_compliance_message = [
        {
          content = "Please use Azure Bastion or VPN instead",
        },
      ]
    },
    {
      name                          = "deny-internet-ssh-policy",
      policy_definition_id          = "/providers/Microsoft.Management/managementGroups/nv_root/providers/Microsoft.Authorization/policyDefinitions/policy-ssh-open-to-internet"
      description                   = "Denies the creation of Network Security Rules that allows SSH access from Internet/Any",
      display_name                  = "Deny NSG allowing inbound traffic on 22 from internet",
      management_group_display_name = "NV Root"
      enforce                       = true,
      parameters                    = file("deny_assignment_parameters.json")
      non_compliance_message = [
        {
          content = "Please use Azure Bastion or VPN instead",
        },
      ]
    },
  ]
}

