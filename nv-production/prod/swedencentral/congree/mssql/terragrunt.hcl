terraform {
  source = "git@github.com:northvolt/tf-mod-azure.git//mssql?ref=v0.7.48"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//mssql"
}

dependency "vnet" {
  config_path = "../subnet"
}

# Include all settings from the root terragrunt.hcl file
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  create_mssql_server           = false
  create_mssql_managed_instance = true
  subnet_id                     = dependency.vnet.outputs.subnets["congree-subnet-sql"].id
  create_administrator_password = true
  name                          = "congree-managed-sql"
  azuread_administrator = {
    group = "NV TechOps Role"
  }
  managed_instance_identity = {
    type = "UserAssigned"
  }

  # Imported databases from congree script
  managed_databases = [
    {
      name                      = "Congree_AuthoringMemory"
      short_term_retention_days = 7
      long_term_retention_policy = {
        weekly_retention  = "P1W"
        monthly_retention = "P1M"
        week_of_year      = 0
      }
    },
    {
      name                      = "Congree_Reporting"
      short_term_retention_days = 7
      long_term_retention_policy = {
        weekly_retention  = "P1W"
        monthly_retention = "P1M"
        week_of_year      = 0
      }
    },
    {
      name                      = "Congree_ScheduledJobs"
      short_term_retention_days = 7
      long_term_retention_policy = {
        weekly_retention  = "P1W"
        monthly_retention = "P1M"
        week_of_year      = 0
      }
    },
    {
      name                      = "Congree_UserManagement"
      short_term_retention_days = 7
      long_term_retention_policy = {
        weekly_retention  = "P1W"
        monthly_retention = "P1M"
        week_of_year      = 0
      }
    },
    {
      name                      = "Congree_Settings"
      short_term_retention_days = 7
      long_term_retention_policy = {
        weekly_retention  = "P1W"
        monthly_retention = "P1M"
        week_of_year      = 0
      }
    },
    {
      name                      = "Congree_Licensing"
      short_term_retention_days = 7
      long_term_retention_policy = {
        weekly_retention  = "P1W"
        monthly_retention = "P1M"
        week_of_year      = 0
      }
    },
    {
      name                      = "Congree_TermTiger"
      short_term_retention_days = 7
      long_term_retention_policy = {
        weekly_retention  = "P1W"
        monthly_retention = "P1M"
        week_of_year      = 0
      }
    },
    {
      name                      = "Congree_DataGrooming"
      short_term_retention_days = 7
      long_term_retention_policy = {
        weekly_retention  = "P1W"
        monthly_retention = "P1M"
        week_of_year      = 0
      }
    },
    {
      name                      = "Congree_Linguistic_English"
      short_term_retention_days = 7
      long_term_retention_policy = {
        weekly_retention  = "P1W"
        monthly_retention = "P1M"
        week_of_year      = 0
      }
    },
  ]
}
