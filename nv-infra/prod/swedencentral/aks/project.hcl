locals {
  cluster_name        = "infra-aks"
  resource_group_name = "${local.cluster_name}-rg"

  tags = {
    infrastructure-owner = "techops@northvolt.com"
    project              = "Infra AKS"
    jira                 = "TOC-2592"
    business-unit        = "109 Digitalization IT - AB"
    department           = "109035 Operations & Infrastructure - AB"
    cost-center          = "109035060 TechOps"
  }
}
