locals {
  azurerm_provider_version = "=1.41.0"
  azurerm_features         = ""
  delete_files             = ["provider.tf"]
  dns_servers              = []
  tags = {
    infrastructure-owner    = "techops@northvolt.com"
    project                 = "800xa"
    jira                    = "TOC-233"
    global-process-owner    = "patrick.weir@northvolt.com"
    recovery-time-objective = "Critical"
  }
}
