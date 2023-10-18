terraform {
  source = "git@github.com:northvolt/tf-mod-azuread.git//app?ref=v1.4.4"
  #source = "${dirname(get_repo_root())}/tf-mod-azuread/app/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  display_name            = "Siemens-ASRS-dev"
  sign_in_audience        = "AzureADMyOrg"
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

  owners_groups = [
    "NV TechOps Role",
  ]

  create_default_role          = false
  id_token_issuance_enabled    = true
  app_role_assignment_required = false

  api = {
    mapped_claims_enabled = false
  }

  implicit_grant = {
    access_token_issuance_enabled = false
    id_token_issuance_enabled     = true
  }

  service_principal_feature_tags = {
    hide       = true
    enterprise = true
  }

  optional_claims = {
    id_token = [
      {
        name = "xms_pl"
      },
      {
        name = "xms_tpl"
      },
      {
        additional_properties = [
          "netbios_domain_and_sam_account_name"
        ]
        name = "groups"
      },
    ]

    access_token = [
      {
        additional_properties = [
          "netbios_domain_and_sam_account_name"
        ]
        name = "groups"
      },
    ]

    saml2_token = [
      {
        additional_properties = [
          "netbios_domain_and_sam_account_name"
        ]
        name = "groups"
      },
    ]
  }

  # Default permissions for microsoft graph
  required_resource_access = [{
    resource_app_name = "MicrosoftGraph"

    resource_access = [
      {
        name = "User.Read"
        type = "Scope"
      },
    ]
  }]

  delegate_permission_claims = ["User.Read"]
  tags                       = null
}

