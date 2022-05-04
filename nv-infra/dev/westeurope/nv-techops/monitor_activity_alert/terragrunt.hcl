terraform {
  #source = "git::git@github.com:northvolt/tf-mod-azure.git//monitor_activity_alert?ref=v0.3.04"
  source = "../../../../../../tf-mod-azure/monitor_activity_alert/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  setup_prefix                  = "techops-monitoring"
  service_health                = true
  alert_name                    = "techops-service-health-alert"
  alert_resource_group_name     = "techops-rg"
  alert_subscription            = "NV_Gen_Infra"
  alert_description             = "Alerts members of the Azure Role: NV TechOps Role of severe service health degradation"
  alert_enabled                 = true

  criteria_category             = "ServiceHealth"
  service_health_events         = ["Incident", "Maintenance", "Security"]
  service_health_locations      = ["West Europe", "North Europe", "Sweden Central"]
  service_health_services       = ["App Service", "App Service (Linux)", "Azure Active Directory", "Azure Active Directory Domain Services", "Azure DNS", "Azure Firewall", "Azure Kubernetes Service (AKS)", "Azure Managed Applications", "Azure Resource Manager", "Backup", "ExpressRoute", "Key Vault", "Load Balancer", "Logic Apps", "Multi-Factor Authentication", "Network Infrastructure", "SQL Database", "SQL Managed Instance", "Storage", "VPN Gateway", "Virtual Machines", "Virtual Network", "Windows Virtual Desktop"]

  action_group_name             = "techops-ag"
  action_group_resource_group   = "techops-rg"

}
