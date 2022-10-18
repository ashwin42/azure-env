terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//monitor_activity_alert?ref=v0.7.6"
  #source = "../../../../../../tf-mod-azure/monitor_activity_alert/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  alerts = [
    {
    service_health                = true
    alert_name                    = "incident-service-health-alert"
    alert_resource_group_name     = "monitoring-ops"
    alert_subscription            = "NV_Gen_Infra"
    alert_description             = "Alerts of severe service health degradation (Service Health Category: Incident)"
    alert_enabled                 = true

    criteria_category             = "ServiceHealth"
    service_health_events         = ["Incident"]
    service_health_locations      = ["West Europe", "North Europe", "Sweden Central"]
    service_health_services       = ["App Service", "App Service (Linux)", "Azure Active Directory", "Azure Active Directory Domain Services", "Azure DNS", "Azure Firewall", "Azure Kubernetes Service (AKS)", "Azure Managed Applications", "Azure Resource Manager", "Backup", "ExpressRoute", "Key Vault", "Load Balancer", "Logic Apps", "Multi-Factor Authentication", "Network Infrastructure", "SQL Database", "SQL Managed Instance", "Storage", "VPN Gateway", "Virtual Machines", "Virtual Network", "Windows Virtual Desktop"]

    action_group_name             = "techops-ag"
    action_group_resource_group   = "monitoring-ops"

    lock_resource                 = false
    },
  ]
}

