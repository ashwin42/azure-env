locals {
  billing_account_name = "9c287b6b-17b0-503d-d8dc-eb9bcdb496c6:7e9d861d-4e15-4889-aa22-7f096c727adc_2019-05-31"
  billing_profile_name = "PQSA-I454-BG7-PGB"
  invoice_section_name = "E5XA-OC4Y-PJA-PGB"
  account_type         = "customer"
  dns_servers          = ["10.40.250.4", "10.40.250.5"]

  # netbox
  netbox_server_url         = "https://netbox.it.aws.nvlt.co"
  update_netbox             = true
  netbox_provider_version   = "~> 3.4.0"
  netbox_secret_aws_profile = "nv-it-prod"

  vpn_subnet_labs = "10.16.8.0/24"
  vpn_subnet_ett  = "10.240.0.0/21"
  vpn_subnet_dwa  = "10.240.32.0/23"
  vpn_subnets_all = [
    local.vpn_subnet_labs,
    local.vpn_subnet_ett,
    local.vpn_subnet_dwa,
  ]

  prometheus_cidr_blocks = [
    "10.15.17.192/26",
    "10.15.18.0/25",
    "10.15.19.0/24",
    "10.15.20.0/23"
  ]

  rule_icmp = [
    {
      name                       = "Allow_ICMP"
      priority                   = "300"
      direction                  = "Inbound"
      source_address_prefix      = "10.0.0.0/8"
      protocol                   = "Icmp"
      destination_address_prefix = "*"
      description                = "Allow ICMP from all"
    }
  ]
  rule_vpn_access = [
    {
      name                       = "Allow_VPN_Access"
      priority                   = "301"
      direction                  = "Inbound"
      source_address_prefixes    = local.vpn_subnets_all
      destination_address_prefix = "*"
      description                = "Allow access from VPN"
    }
  ]
  rule_windows_node_exporter = [
    {
      name                       = "Allow_Windows_Node_Exporter"
      priority                   = "302"
      direction                  = "Inbound"
      source_address_prefixes    = local.prometheus_cidr_blocks
      destination_port_range     = "9182"
      protocol                   = "Tcp"
      destination_address_prefix = "*"
      description                = "Allow access from Prometheus"
    }
  ]

  # default SG rules for all VMs
  default_rules = concat(
    local.rule_icmp,
    local.rule_vpn_access,
    local.rule_windows_node_exporter
  )
}
