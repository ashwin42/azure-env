data "azuread_client_config" "current" {}

resource "azuread_application" "this" {
  display_name                   = "Siemens-ASRS-prod"
  owners                         = [data.azuread_client_config.current.object_id]
  sign_in_audience               = "AzureADMyOrg"
  fallback_public_client_enabled = false
  group_membership_claims        = ["SecurityGroup"]

  api {
  }

  web {
    redirect_uris = [
      "http://localhost:5000/",
      "http://localhost:5000/signin-oidc",
      "https://asrs-nv1-prod-cathode-as.azurewebsites.net/",
      "https://asrs-nv1-prod-cathode-as.azurewebsites.net/signin-oidc",
      "https://asrs-nv1-prod-anode-as.azurewebsites.net/",
      "https://asrs-nv1-prod-anode-as.azurewebsites.net/signin-oidc",
    ]
    implicit_grant {
      access_token_issuance_enabled = false
      id_token_issuance_enabled     = true
    }
  }

  optional_claims {
    access_token {
      additional_properties = [
        "netbios_domain_and_sam_account_name",
      ]
      essential = false
      name      = "groups"
    }
    id_token {
      additional_properties = []
      essential             = false
      name                  = "xms_pl"
    }
    id_token {
      additional_properties = []
      essential             = false
      name                  = "xms_tpl"
    }
    id_token {
      additional_properties = [
        "netbios_domain_and_sam_account_name",
      ]
      essential = false
      name      = "groups"
    }
    saml2_token {
      additional_properties = [
        "netbios_domain_and_sam_account_name",
      ]
      essential = false
      name      = "groups"
    }
  }

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000"

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"
      type = "Scope"
    }
  }
}

resource "azuread_service_principal" "this" {
  application_id = azuread_application.this.application_id
  tags = [
    "HideApp",
    "WindowsAzureActiveDirectoryIntegratedApp",
  ]
}

