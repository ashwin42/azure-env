terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//app?ref=v1.2.1"
  #source = "../../../../../../tf-mod-azuread/app/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  display_name            = "Siemens-ASRS-dev"
  homepage                = "https://asrs-wcs-dev-as.azurewebsites.net"
  group_membership_claims = ["All", "ApplicationGroup"]
  redirect_uris = [
    "http://localhost:5000/",
    "http://localhost:5000/signin-oidc",
    "https://asrs-nv1-dev-anode-as.azurewebsites.net/",
    "https://asrs-nv1-dev-anode-as.azurewebsites.net/signin-oidc",
    "https://asrs-nv1-prod-cathode-as.azurewebsites.net/",
    "https://asrs-nv1-prod-cathode-as.azurewebsites.net/signin-oidc",
    "https://asrs-wcs-dev-as.azurewebsites.net/",
    "https://asrs-wcs-dev-as.azurewebsites.net/signin-oidc",
  ]

  tag_hide                          = true
  create_default_role               = false
  id_token_issuance_enabled         = true
  create_msgraph_principal          = false
  app_role_assignment_required      = false
  create_delegated_permission_grant = false

  optional_claims = [
    {
      id_token = {
        additional_properties = []
        essential             = false
        name                  = "xms_pl"
      }
    },
    {
      id_token = {
        additional_properties = []
        essential             = false
        name                  = "xms_tpl"
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
      access_token = {
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
        id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"
        type = "Scope"
      },
    ]
  }]

  delegate_permission_claims = ["openid", "User.Read", "email", "profile"]
}


