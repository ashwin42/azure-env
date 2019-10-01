variable "application_name" {
  default = "teamcenter"
}

variable "enable_render_server" {
  default = false
}

variable "targetdir" {
  default = "teamcenter"
}

variable "storage_access_key" {}
variable "password" {}
variable "database_password" {}

variable "teamcenter_server_count" {
  default = 1
}

variable "teamcenter_vm_size" {}
variable "teamcenter_data_disk_size" {}
variable "tc_gpu_vm_size" {}
variable "tc_gpu_data_disk_size" {}
variable "tc_license_vm_size" {}
variable "resource_group_name" {}
variable "storage_account_name" {}
variable "subnet_id" {}
variable "subnet_prefix" {}
variable "location" {}
variable "stage" {}
variable "blob_name" {}
variable "db_server_size" {}
variable "public_ssh_key_path" {}
variable "k8s_service_principal_id" {}
variable "k8s_service_principal_password" {}

variable "k8s_vm_size" {
  default = "Standard_D1_v2"
}

variable "k8s_vm_count" {
  default = 1
}
