terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.7.59"
  # source = "${dirname(get_repo_root())}/tf-mod-azure//vm/netbox"
}

include {
  path = find_in_parent_folders()
}

dependency "rv" {
  config_path = "../../recovery_vault"
}

dependency "subnet" {
  config_path = "../../subnet"
}

locals {
  setup_prefix = "ms-oda"
  name         = basename(get_original_terragrunt_dir())
  subnet       = "ms-ondemand-assessments-subnet"
  host_pool    = "ms-oda-data-collector-hp"
}

inputs = {
  netbox_create_role                     = true
  recovery_vault_name                    = dependency.rv.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  vm_name                                = "${local.setup_prefix}-${local.name}"
  vm_size                                = "Standard_B4ms"
  backup_vm                              = true
  create_localadmin_password             = true
  storage_account_name                   = "nvinfrabootdiag"
  boot_diagnostics_enabled               = true
  ad_join                                = true
  managed_disk_size                      = 127
  storage_image_reference = {
    sku = include.root.locals.all_vars.windows_server_sku
  }

  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
    timezone                  = "W. Europe Standard Time"
  }

  os_profile = {
    admin_username = "nvadmin"
    computer_name  = "ms-oda-data"
  }

  # identity = {
  #   type = "SystemAssigned"
  # }

  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          private_ip_address            = "10.46.2.68"
          subnet_id                     = dependency.subnet.outputs.subnets["${local.subnet}"].id
          public_ip                     = false
          private_ip_address_allocation = "Static"
        },
      ]
    },
  ]
  custom_rules = [
    {
      name                  = "Labs_MFA_VPN"
      priority              = "200"
      direction             = "Inbound"
      source_address_prefix = "10.16.8.0/24"
      description           = "Allow connections from Labs MFA VPN clients"
    },
    {
      name                  = "Ett_MFA_VPN"
      priority              = "201"
      direction             = "Inbound"
      source_address_prefix = "10.240.0.0/21"
      description           = "Allow connections from Ett MFA VPN clients"
    },
  ]
}

