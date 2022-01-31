data "azuread_client_config" "current" {}

data "azuread_application_published_app_ids" "well_known" {}

resource "azuread_service_principal" "msgraph" {
  application_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
  use_existing   = true
}

# App registration
resource "azuread_application" "this" {
  display_name                   = "Remote Access Server Ett - Guacamole"
  owners                         = [data.azuread_client_config.current.object_id]
  sign_in_audience               = "AzureADMyOrg"
  fallback_public_client_enabled = false
  group_membership_claims        = ["SecurityGroup"]

  api {
  }

  web {
    homepage_url  = "https://rdweb-01.ett.nvlt.net"
    redirect_uris = [
      "https://rdweb-01.ett.nvlt.net/",
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
    resource_app_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph

    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["User.Read"]
      type = "Scope"
    }
    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["openid"]
      type = "Scope"
    }
    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["email"]
      type = "Scope"
    }
    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["profile"]
      type = "Scope"
    }
  }
}

# Enterprise application
resource "azuread_service_principal" "this" {
  application_id = azuread_application.this.application_id
  app_role_assignment_required = true
  tags = [
    "WindowsAzureActiveDirectoryIntegratedApp",
  ]
}

# Permissions
resource "azuread_service_principal_delegated_permission_grant" "this" {
  service_principal_object_id          = azuread_service_principal.this.object_id
  resource_service_principal_object_id = azuread_service_principal.msgraph.object_id
  claim_values                         = ["openid", "User.Read", "email", "profile"]
}

