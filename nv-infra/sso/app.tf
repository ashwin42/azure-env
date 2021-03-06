resource "azuread_application" "nv-auth-dev" {
  available_to_other_tenants = false
  group_membership_claims    = "ApplicationGroup"
  homepage                   = "https://account.activedirectory.windowsazure.com:444/applications/default.aspx?metadata=customappsso|ISV9.1|primary|z"
  identifier_uris            = ["urn:amazon:cognito:sp:eu-west-1_oPiNz53Bm", ]
  name                       = "nv-auth-dev"
  oauth2_allow_implicit_flow = false
  owners                     = ["50e4c26c-2bf0-4244-af96-c397265c7fbe", "8b9192b7-d730-48f2-85b0-383eecc2280e", "b12a84bf-ad06-476c-abb7-60a44df55607", "b49675c2-cdef-474d-94b3-de0b0342dc5a", "bf088366-c2ed-4095-bb7b-9995db7c2899"]
  public_client              = false
  reply_urls                 = ["http://127.0.0.1:53122", "https://013ce941-default-publicing-448e-1447706243.eu-west-1.elb.amazonaws.com/", "https://013ce941-default-publicing-448e-1447706243.eu-west-1.elb.amazonaws.com/oauth2/idpresponse", "https://airflow.datalake.aws.nvlt.co/oauth2/idpresponse", "https://auth-dev.nvlt.co/saml2/idpresponse", "https://ca.dev.nvlt.co", "https://devhellos3.aut-dev.aws.nvlt.co/oauth2/idpresponse", "https://flink.datalake.aws.nvlt.co/oauth2/idpresponse", "https://gql-pub.aut-dev.aws.nvlt.co", "https://gql-pub.aut-dev.aws.nvlt.co/oauth2/idpresponse", "https://gql.aut-dev.aws.nvlt.co/oauth2/idpresponse", "https://gql.aut.aws.nvlt.co/oauth2/idpresponse", "https://search-ds-northvolt-hifsabjmw6acy6f2m565dkaswi.eu-west-1.es.amazonaws.com/_plugin/kibana/app/kibana", "https://superset.datalake.aws.nvlt.co/oauth2/idpresponse", "https://wirebonder.aut-dev.aws.nvlt.co", "https://wirebonder.aut-dev.aws.nvlt.co/oauth2/idpresponse"]
  type                       = "webapp/api"

  app_role {
    allowed_member_types = [
      "User",
    ]

    description  = "User"
    display_name = "User"
    is_enabled   = true
  }

  app_role {
    allowed_member_types = [
      "User",
    ]

    description  = "msiam_access"
    display_name = "msiam_access"
    is_enabled   = true
  }

  oauth2_permissions {
    admin_consent_description  = "Allow the application to access nv-auth-dev on behalf of the signed-in user."
    admin_consent_display_name = "Access nv-auth-dev"
    is_enabled                 = true
    type                       = "User"
    user_consent_description   = "Allow the application to access nv-auth-dev on your behalf."
    user_consent_display_name  = "Access nv-auth-dev"
    value                      = "user_impersonation"
  }

  optional_claims {
    access_token {
      additional_properties = []
      essential             = false
      name                  = "groups"
    }

    id_token {
      additional_properties = []
      essential             = false
      name                  = "groups"
    }
  }
}
