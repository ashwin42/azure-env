output "virtual_network_name" {
  value = "${module.azure_core.virtual_network_name}"
}

output "subnet_internal_id" {
  value = "${module.azure_core.subnet_internal_id}"
}
