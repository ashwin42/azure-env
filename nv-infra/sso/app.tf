resource "azuread_application" "nv-auth-dev" {
  application_id             = "be8d485f-e54c-4031-95a6-ad0f61e2d50e"
  available_to_other_tenants = false
  group_membership_claims    = "SecurityGroup"
  homepage                   = "https://account.activedirectory.windowsazure.com:444/applications/default.aspx?metadata=customappsso|ISV9.1|primary|z"
  id                         = "fd1f6237-cd59-45e7-9972-05d642cc8d2d"
  identifier_uris            = ["urn:amazon:cognito:sp:eu-west-1_oPiNz53Bm", ]
  name                       = "nv-auth-dev"
  oauth2_allow_implicit_flow = false
  object_id                  = "fd1f6237-cd59-45e7-9972-05d642cc8d2d"
  owners                     = ["50e4c26c-2bf0-4244-af96-c397265c7fbe", "b12a84bf-ad06-476c-abb7-60a44df55607", "b49675c2-cdef-474d-94b3-de0b0342dc5a", "bf088366-c2ed-4095-bb7b-9995db7c2899"]
  public_client              = false
  reply_urls                 = ["http://127.0.0.1:53122", "https://013ce941-default-publicing-448e-1447706243.eu-west-1.elb.amazonaws.com/", "https://013ce941-default-publicing-448e-1447706243.eu-west-1.elb.amazonaws.com/oauth2/idpresponse", "https://auth-dev.nvlt.co/saml2/idpresponse", "https://ca.dev.nvlt.co", "https://gql-pub.aut-dev.aws.nvlt.co", "https://gql-pub.aut-dev.aws.nvlt.co/oauth2/idpresponse", "https://idevhellos3.aut-dev.aws.nvlt.co/oauth2/idpresponse", "https://search-ds-northvolt-hifsabjmw6acy6f2m565dkaswi.eu-west-1.es.amazonaws.com/_plugin/kibana/app/kibana", "https://superset.aut-dev.aws.nvlt.co", "https://superset.aut-dev.aws.nvlt.co/oauth2/idpresponse", "https://wirebonder.aut-dev.aws.nvlt.co", "https://wirebonder.aut-dev.aws.nvlt.co/oauth2/idpresponse"]
  type                       = "webapp/api"

  app_role {
    allowed_member_types = [
      "User",
    ]

    description  = "User"
    display_name = "User"
    id           = "18d14569-c3bd-439b-9a66-3a2aee01d14f"
    is_enabled   = true
  }

  app_role {
    allowed_member_types = [
      "User",
    ]

    description  = "msiam_access"
    display_name = "msiam_access"
    id           = "b9632174-c057-4f7e-951b-be3adc52bfe6"
    is_enabled   = true
  }

  oauth2_permissions {
    admin_consent_description  = "Allow the application to access nv-auth-dev on behalf of the signed-in user."
    admin_consent_display_name = "Access nv-auth-dev"
    id                         = "c48d8cd4-9255-46fa-9a49-a27957126aad"
    is_enabled                 = true
    type                       = "User"
    user_consent_description   = "Allow the application to access nv-auth-dev on your behalf."
    user_consent_display_name  = "Access nv-auth-dev"
    value                      = "user_impersonation"
  }
}
