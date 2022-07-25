terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.2.15"
}

include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

inputs = {
  setup_prefix                           = dependency.global.outputs.setup_prefix
  vm_name                                = "${basename(dirname(get_parent_terragrunt_dir()))}"
  recovery_vault_name                    = dependency.global.outputs.recovery_services.recovery_vault_name
  recovery_vault_resource_group          = dependency.global.outputs.resource_group.name
  recovery_services_protection_policy_id = dependency.global.outputs.recovery_services.protection_policy_daily_id
  resource_group_name                    = dependency.global.outputs.resource_group.name
  vm_name                                = "nv-network-mon"
  vm_size                                = "Standard_B2s"
  managed_disk_name                      = "nv-network-mon-os"
  backup_vm                              = true
  key_vault_name                         = "nv-infra-core"
  key_vault_rg                           = "nv-infra-core"
  localadmin_name                        = "nvadmin"
  localadmin_key_name                    = "nv-network-mon"
  nsg0_name_alt                          = "nv_network_mon_nsg"
  storage_account_name                   = "nvinfrabootdiag"
  ipconfig_name                          = "nv-network-mon-nic_config"
  public_ip                              = true
  public_ip_name                         = "nv-network-mon-ip"
  public_ip_allocation_method            = "Static"
  ad_join                                = false
  data_disks = [
    {
      name                 = "nv-network-mon-data1"
      size                 = "50"
      lun                  = "5"
      storage_account_type = "StandardSSD_LRS"
    }
  ]
  storage_image_reference = {
    offer     = "UbuntuServer",
    publisher = "Canonical",
    sku       = "18.04-LTS",
  }
  network_interfaces = [
    {
      name      = "nv-network-mon-nic"
      ipaddress = "10.44.3.4"
      subnet    = dependency.global.outputs.subnet.nv_network_mon_subnet.id
      public_ip = true
    }
  ],
  custom_rules = [
    {
      name                  = "Labs_MFA_VPN"
      priority              = "200"
      direction             = "Inbound"
      source_address_prefix = "10.16.8.0/23"
      access                = "Allow"
      description           = "Allow connections from Labs MFA VPN clients"
    },
    {
      name                  = "Labs_MGMT"
      priority              = "210"
      direction             = "Inbound"
      source_address_prefix = "10.254.6.0/24"
      access                = "Allow"
      description           = "Allow connections from Labs MGMT network"
    },
    {
      name                  = "Factory"
      priority              = "220"
      direction             = "Inbound"
      protocol              = "Tcp"
      source_address_prefix = "213.50.54.192/28"
      access                = "Allow"
      description           = "Allow connections from Labs MFA VPN clients"
    },
    {
      name                  = "Temp_Office"
      priority              = "230"
      direction             = "Inbound"
      source_address_prefix = "62.20.55.58"
      access                = "Allow"
      description           = "Allow connections from Labs MFA VPN clients"
    },
    {
      name                  = "Factory_Telia"
      priority              = "240"
      direction             = "Inbound"
      protocol              = "Tcp"
      source_address_prefix = "62.20.23.0/28"
      access                = "Allow"
      description           = "Allow connections from Labs clients"
    },
  ]
}

