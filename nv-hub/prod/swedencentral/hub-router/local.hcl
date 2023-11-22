locals {
  providers = ["azurerm", "netbox"]
  tags = {
    infrastructure-owner    = "techops@northvolt.com"
    system-owner            = "techops@northvolt.com"
    recovery-time-objective = "Critical"
    project                 = "Hub Routers"
    business-unit           = "109 Digitalization IT - AB"
    department              = "109037 IT Common - AB"
    cost-center             = "109037064 IT Common - AB"
  }
}
