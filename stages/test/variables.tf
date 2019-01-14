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
variable "client_gateway_subnet_address_prefix" {}
variable "client_address_space" {}
variable "subnet_internal_prefix" {}
variable "gateway_connection_psk" {}
variable "admin_password" {}
variable "database_password" {}
variable "teamcenter_vm_size" {}
variable "teamcenter_server_count" {}
variable "enable_render_server" {}
variable "tc_gpu_vm_size" {}
variable "tc_license_vm_size" {}
variable "teamcenter_data_disk_size" {}
variable "tc_gpu_data_disk_size" {}
variable "blob_name" {}
variable "db_server_size" {}
variable "public_ssh_key_path" {}
variable "k8s_service_principal_password" {}
variable "k8s_service_principal_id" {}
variable "k8s_vm_size" {}
variable "k8s_vm_count" {}
variable "abb800xa_base_ip" {}
variable "abb800xa_application_name" {}
