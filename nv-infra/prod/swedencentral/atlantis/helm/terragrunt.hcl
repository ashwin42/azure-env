terraform {
  source = "github.com/terraform-module/terraform-helm-release.git//?ref=v2.8.1"
}

dependency "cluster" {
  config_path = "../../aks/cluster"
}

dependency "identity" {
  config_path = "../workload_identity"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  helm_aks_cluster_name              = dependency.cluster.outputs.aks_name
  helm_aks_resource_group_name       = split("/", dependency.cluster.outputs.aks_id)[4]
  kubernetes_aks_cluster_name        = dependency.cluster.outputs.aks_name
  kubernetes_aks_resource_group_name = split("/", dependency.cluster.outputs.aks_id)[4]

  namespace  = "atlantis"
  repository = "https://runatlantis.github.io/helm-charts"

  app = {
    name             = "atlantis"
    version          = "4.15.1"
    chart            = "atlantis"
    deploy           = true
    create_namespace = true
  }

  values = [templatefile("./values.yml",
    {
      arm_client_id = dependency.identity.outputs.client_id
    }
  )]
}
