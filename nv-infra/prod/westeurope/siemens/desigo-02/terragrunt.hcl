terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm/netbox?ref=v0.8.0"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm/netbox"
}

include {
  path = find_in_parent_folders()
}

dependency "vnet" {
  config_path = "../vnet"
}

dependency "rv" {
  config_path = "../recovery_vault"
}

locals {
  name = basename(get_terragrunt_dir())
}

inputs = {
  recovery_vault_resource_group          = dependency.rv.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.rv.outputs.recovery_services.protection_policy_daily_id
  name                                   = local.name
  vm_size                                = "Standard_D8s_v5"
  backup_vm                              = true
  storage_account_name                   = "nvinfrabootdiag"
  ad_join                                = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  localadmin_key_name                    = "${local.name}-nvadmin"
  create_localadmin_password             = true
  managed_disk_name                      = "${local.name}-os"
  managed_disk_type                      = "StandardSSD_LRS"

  storage_image_reference = {
    offer     = include.root.locals.all_vars.windows_server_offer,
    publisher = include.root.locals.all_vars.windows_server_publisher,
    sku       = "2022-Datacenter",
  }

  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = false
    timezone                  = "W. Europe Standard Time"
  }

  os_profile = {
    admin_username = "nvadmin"
    computer_name  = local.name
  }

  network_security_groups = [
    {
      name               = "${local.name}-nic-nsg"
      move_default_rules = true
      rules = [
        {
          name                  = "LocalVnet"
          priority              = "205"
          direction             = "Inbound"
          source_address_prefix = dependency.vnet.outputs.virtual_network.address_space[0]
          access                = "Allow"
          description           = "Allow connections from local VNet"
        },
      ]
    },
  ]

  network_interfaces = [
    {
      name                = "${local.name}-nic"
      security_group_name = "${local.name}-nic-nsg"
      ip_configuration = [
        {
          private_ip_address            = "10.44.1.146"
          subnet_id                     = dependency.vnet.outputs.subnets.siemens_system_subnet.id
          ipconfig_name                 = "${local.name}-nic_config"
          private_ip_address_allocation = "Static"
        },
      ]
    },
  ]

  data_disks = [
    {
      name                 = "${local.name}-data1"
      size                 = "512"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
    }
  ]
}

