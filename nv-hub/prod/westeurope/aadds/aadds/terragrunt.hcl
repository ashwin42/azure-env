terraform {
  #source = "git::git@github.com:northvolt/tf-mod-azure.git//vnet?ref=v0.6.12"
  source = "../../../../../../tf-mod-azure/aadds"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "subnet" {
  config_path = "../subnet"
}

inputs = {
  name                      = "aadds.northvolt.com"
  create_service_principal  = true
  create_security_group     = true
  security_group_name       = "aadds-nsg"
  subnet_id                 = dependency.subnet.outputs.subnets["nv-domain-services"].id
  domain_name               = "aadds.northvolt.com"
  sku                       = "Standard"
  domain_configuration_type = "FullySynced"
  lock_resources            = true

  initial_replica_set = {
    subnet_id = dependency.subnet.outputs.subnets["nv-domain-services"].id
  }

  notifications = {
    additional_recipients = [
      "ali@norhtvolt.com",
      "christian@northvolt.com",
      "infosec@northvolt.com",
      "mathias.kujala@northvolt.com",
    ]
    notify_dc_admins     = true
    notify_global_admins = true
  }

  security = {
    kerberos_armoring_enabled       = true
    kerberos_rc4_encryption_enabled = true
    ntlm_v1_enabled                 = false
    sync_kerberos_passwords         = true
    sync_ntlm_passwords             = true
    sync_on_prem_passwords          = true
    tls_v1_enabled                  = true
  }

  iam_assignments = {
    "Domain Services Contributor" = {
      groups = [
        "NV TechOps Role",
        "NV TechOps Lead Role",
      ],
    },
  }
}
