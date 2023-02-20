terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//vm?ref=v0.7.35"
  #source = "${dirname(get_repo_root())}/tf-mod-azure//vm/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vnet" {
  config_path = "../subnet"
}

dependency "wvd" {
  config_path = "../wvd"
}

locals {
  name = "${include.root.inputs.project_name}-aad-mdm"
}

inputs = {
  delete_os_disk_on_termination = true
  token                         = dependency.wvd.outputs.tokens[local.name]
  host_pool_name                = dependency.wvd.outputs.host_pools[local.name].name
  name                          = "wvd-test-mdm"
  vm_size                       = "Standard_B4ms"
  key_vault_name                = "nv-infra-core"
  key_vault_rg                  = "nv-infra-core"
  aad_join                      = true
  mdm_register                  = true
  wvd_register                  = true
  create_localadmin_password    = true

  storage_image_reference = {
    offer     = "Windows-10",
    publisher = "MicrosoftWindowsDesktop",
    sku       = "21h1-evd-g2",
    version   = "latest"
  }

  os_profile_windows_config = {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
    timezone                  = "W. Europe Standard Time"
  }

  identity = {
    type = "SystemAssigned"
  }

  network_interfaces = [
    {
      name = "${local.name}-nic"
      ip_configuration = [
        {
          subnet_id = dependency.vnet.outputs.subnets[include.root.inputs.project_name].id
        },
      ]
    },
  ]
  custom_rules = [
    {
      name                   = "Labs_MFA_VPN"
      priority               = "200"
      direction              = "Inbound"
      source_address_prefix  = "10.16.8.0/23"
      protocol               = "*"
      destination_port_range = "0-65535"
      access                 = "Allow"
      description            = "Allow connections from Labs MFA VPN clients"
    },
  ]

  iam_assignments = {
    "Virtual Machine Administrator Login" = {
      groups = [
        "NV TechOps Role",
        "NV IT Core Role",
      ],
    },
  }
}

