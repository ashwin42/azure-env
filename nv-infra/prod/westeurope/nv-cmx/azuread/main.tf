resource "azuread_group" "this" {
  for_each                = var.groups == null ? {} : { for group in var.groups : group.display_name => group }
  description             = format("%s%s%s", lookup(each.value, "description", null), " - Managed by Terraform, repo: ", lookup(var.repo_tag, "repo", ""))
  display_name            = each.value.display_name
  owners                  = lookup(each.value, "owners", null)
  prevent_duplicate_names = lookup(each.value, "prevent_duplicate_names", true)
}

locals {
  group_members = flatten([
    for group in var.groups : [
      for member in group.members : {
        user_principal_name = member
        group               = group.display_name
      }
    ]
  ])
}

data "azuread_user" "this" {
  for_each            = { for user in local.group_members : user.user_principal_name => user }
  user_principal_name = each.value.user_principal_name
}

resource "azuread_group_member" "this" {
  for_each         = { for user in local.group_members : format("%s - %s", user.user_principal_name, user.group) => user }
  group_object_id  = azuread_group.this[each.value.group].id
  member_object_id = data.azuread_user.this[each.value.user_principal_name].id
}

