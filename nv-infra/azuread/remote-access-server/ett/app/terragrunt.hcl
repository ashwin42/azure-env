terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//app?ref=v1.2.1"
  #source = "../../../../../../tf-mod-azuread/app/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  display_name              = "Remote Access Server Ett - Guacamole"
  homepage                  = "https://rdweb-01.ett.nvlt.net"
  group_membership_claims   = ["SecurityGroup"]
  redirect_uris             = ["https://rdweb-01.ett.nvlt.net/"]
  id_token_issuance_enabled = true
  create_default_role       = false

  optional_claims = [
    {
      access_token = {
        additional_properties = [
          "netbios_domain_and_sam_account_name"
        ]
        essential = false
        name      = "groups"
      }
    },
    {
      id_token = {
        additional_properties = [
          "netbios_domain_and_sam_account_name"
        ]
        essential = false
        name      = "groups"
      }
    },
    {
      saml2_token = {
        additional_properties = [
          "netbios_domain_and_sam_account_name"
        ]
        essential = false
        name      = "groups"
      }
    },
  ]

  required_resource_access = [{
    resource_app_name = "MicrosoftGraph"

    resource_access = [
      {
        name = "User.Read"
        type = "Scope"
      },
      {
        name = "openid"
        type = "Scope"
      },
      {
        name = "email"
        type = "Scope"
      },
      {
        name = "profile"
        type = "Scope"
      }
    ]
  }]

  delegate_permission_claims = ["openid", "User.Read", "email", "profile"]

}

