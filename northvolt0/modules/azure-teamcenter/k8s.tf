resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "${var.application_name}-cluster"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "cluster"

  agent_pool_profile {
    name            = "default"
    count           = var.k8s_vm_count
    vm_size         = var.k8s_vm_size
    os_type         = "Linux"
    os_disk_size_gb = 30
    vnet_subnet_id  = var.subnet_id
  }

  linux_profile {
    admin_username = "nvadmin"

    ssh_key {
      key_data = file(var.public_ssh_key_path)
    }
  }

  service_principal {
    client_id     = var.k8s_service_principal_id
    client_secret = var.k8s_service_principal_password
  }

  tags = {
    stage = "test"
  }
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.cluster.kube_config[0].client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.cluster.kube_config_raw
}

