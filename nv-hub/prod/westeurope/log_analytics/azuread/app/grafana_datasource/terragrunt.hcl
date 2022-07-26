terraform {
  #source = "git@github.com:northvolt/tf-mod-azuread.git//app?ref=v1.2.3"
  source = "../../../../../../../../tf-mod-azuread/app/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  display_name              = "Grafana Dev - Azure Monitor Datasource"
  redirect_uris             = ["https://grafana.aut-dev.aws.nvlt.co/"]
  id_token_issuance_enabled = false
  create_default_role       = false
  create_delegated_permission_grant = false
  create_msgraph_principal = false
  app_role_assignment_required = false
  tag_hide = true


  required_resource_access = [{
    resource_app_id = "00000003-0000-0000-c000-000000000000"

    resource_access = [
      {
        id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"
        type = "Scope"
      },
    ]
  }]
}

