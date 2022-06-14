# Create an Aviatrix Azure Account
resource "aviatrix_account" "temp_acc_azure" {
  account_name        = "azure-hub-dev"
  cloud_type          = 8
  arm_subscription_id = var.subscription_id
  arm_directory_id    = var.directory_id
  arm_application_id  = var.application_id

  # Acquired locally by terragrunt output -json in app module.
  arm_application_key = ""
}
