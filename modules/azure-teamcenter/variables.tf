variable "application_name" {
  default = "teamcenter"
}

variable "storage_access_key" {}
variable "password" {}
variable "database_password" {}
variable "teamcenter_vm_size" {}
variable "teamcenter_data_disk_size" {}
variable "webtier_vm_size" {}
variable "webtier_data_disk_size" {}
variable "resource_group_name" {}
variable "storage_account_name" {}
variable "subnet_id" {}
variable "location" {}
variable "stage" {}
variable "blob_name" {}

variable "targetdir" {
  default = "teamcenter"
}
