variable "resource_group_name" {}

variable "location" {
  default = "northeurope"
}

variable "storage_account_name" {}
variable "storage_access_key" {}
variable "stage" {}

variable "virtual_network_address_space" {
  type = "list"
}

variable "gateway_subnet_address_prefix" {}
variable "subnet_internal_prefix" {}
variable "gateway_connection_psk" {}
variable "admin_password" {}
variable "database_password" {}
variable "teamcenter_vm_size" {}
variable "enable_render_server" {}
variable "tc_gpu_vm_size" {}
variable "tc_license_vm_size" {}
variable "teamcenter_data_disk_size" {}
variable "tc_gpu_data_disk_size" {}
variable "blob_name" {}
variable "db_server_size" {}
