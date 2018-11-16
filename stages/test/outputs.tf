output "virtual_network_name" {
  value = "${module.azure_core.virtual_network_name}"
}

output "subnet_internal_id" {
  value = "${module.azure_core.subnet_internal_id}"
}

output "k8s_client_certificate" {
  value = "${module.azure-teamcenter.client_certificate}"
}

output "kube_config" {
  value = "${module.azure-teamcenter.kube_config}"
}
