terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//app?ref=v1.2.1"
  #source = "../../../../../../../tf-mod-azuread/app/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  display_name            = "Siemens-ASRS-prod"
  group_membership_claims = ["SecurityGroup"]
  redirect_uris = [
    "http://localhost:5000/",
    "http://localhost:5000/signin-oidc",
    "https://asrs-nv1-prod-cathode-as.azurewebsites.net/",
    "https://asrs-nv1-prod-cathode-as.azurewebsites.net/signin-oidc",
    "https://asrs-nv1-prod-anode-as.azurewebsites.net/",
    "https://asrs-nv1-prod-anode-as.azurewebsites.net/signin-oidc",
    "https://asrs-nv1-prod-cw1-as.azurewebsites.net/",
    "https://asrs-nv1-prod-cw1-as.azurewebsites.net/signin-oidc",
    "https://asrs-nv1-prod-fa1-as.azurewebsites.net/",
    "https://asrs-nv1-prod-fa1-as.azurewebsites.net/signin-oidc",
    "https://asrs-nv1-prod-spw-as.azurewebsites.net/",
    "https://asrs-nv1-prod-spw-as.azurewebsites.net/signin-oidc",

  ]

  id_token_issuance_enabled         = true
  create_delegated_permission_grant = false
  create_msgraph_principal          = false
  app_role_assignment_required      = false
  create_default_role               = false

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
      saml2_token = {
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
  ]

  tag_hide = true

  # Default permissions for microsoft graph
  required_resource_access = [{
    resource_app_id = "00000003-0000-0000-c000-000000000000"

    resource_access = [
      {
        id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read	
        type = "Scope"
      },
    ]
  }]

}

