stage = "test"

resource_group_name = "nv-automation-test"

storage_account_name = "nvautomationtest"

virtual_network_address_space = ["10.1.0.0/16"]

gateway_subnet_address_prefix = "10.1.1.0/27"

client_gateway_subnet_address_prefix = "10.1.2.0/24"

client_address_space = "10.1.3.0/24"

subnet_internal_prefix = "10.1.10.0/24"

teamcenter_vm_size = "Standard_D4_v3"

teamcenter_data_disk_size = "1000"

enable_render_server = false

tc_gpu_vm_size = "Standard_NV6"

tc_license_vm_size = "Standard_B2s"

tc_gpu_data_disk_size = "100"

blob_name = "Tc12.0.0.0_wntx64_1_of_2.zip"

db_server_size = "GP_Gen4_8"

teamcenter_server_count = 1

public_ssh_key_path = "id_rsa.pub"

k8s_service_principal_id = "b950c89d-0fb7-4492-ae8f-7b7ccc4db6d3"

k8s_vm_size = "Standard_D1_v2"

k8s_vm_count = 1

abb800xa_base_ip = 210

abb800xa_application_name = "abb800xa"
