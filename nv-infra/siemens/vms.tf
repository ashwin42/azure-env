resource "azurerm_availability_set" "nv_siemens_avs" {
  name                = "nv_siemens_avs"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  managed             = true
}

# -- Desigo CC --
data "azurerm_key_vault_secret" "nv-siemens-desigo" {
  name         = "nv-siemens-desigo"
  key_vault_id = "${data.azurerm_key_vault.nv-infra-core.id}"
}

resource "azurerm_network_interface" "desigo_secondary_nic" {
  name                      = "desigo-second-nic"
  resource_group_name       = "${var.resource_group_name}"
  location                  = "${var.location}"
  network_security_group_id = "${azurerm_network_security_group.nv_siemens_nsg.id}"

  ip_configuration {
    name                          = "desigo-second-nic_config"
    subnet_id                     = azurerm_subnet.siemens_cameras.id
    private_ip_address_allocation = "static"
    private_ip_address            = "10.44.1.40"
  }
}

module "nv-siemens-desigo" {
  source                 = "../modules/windows-server"
  security_group_id      = "${azurerm_network_security_group.nv_siemens_nsg.id}"
  name                   = "desigo"
  ipaddress              = "10.44.1.135"
  password               = "${data.azurerm_key_vault_secret.nv-siemens-desigo.value}"
  location               = "${var.location}"
  resource_group_name    = "${var.resource_group_name}"
  subnet_id              = azurerm_subnet.siemens_system_subnet.id
  vault_id               = "${data.azurerm_key_vault.nv-infra-core.id}"
  recovery_vault_name    = var.recovery_vault_name
  backup_policy_id       = var.backup_policy_id
  vm_size                = "Standard_D4s_v3"
  managed_data_disk_size = "1024"
  secondary_nic          = "${azurerm_network_interface.desigo_secondary_nic.id}"
  availability_set       = azurerm_availability_set.nv_siemens_avs.id
}

# -- VMS --
data "azurerm_key_vault_secret" "nv-siemens-vms" {
  name         = "nv-siemens-vms"
  key_vault_id = "${data.azurerm_key_vault.nv-infra-core.id}"
}

resource "azurerm_network_interface" "vms_secondary_nic" {
  name                      = "vms-second-nic"
  resource_group_name       = "${var.resource_group_name}"
  location                  = "${var.location}"
  network_security_group_id = "${azurerm_network_security_group.nv_siemens_nsg.id}"

  ip_configuration {
    name                          = "vms-second-nic_config"
    subnet_id                     = azurerm_subnet.siemens_cameras.id
    private_ip_address_allocation = "static"
    private_ip_address            = "10.44.1.43"
  }
}

module "nv-siemens-vms" {
  source                 = "../modules/windows-server"
  security_group_id      = "${azurerm_network_security_group.nv_siemens_nsg.id}"
  name                   = "vms"
  ipaddress              = "10.44.1.136"
  password               = "${data.azurerm_key_vault_secret.nv-siemens-vms.value}"
  location               = "${var.location}"
  resource_group_name    = "${var.resource_group_name}"
  subnet_id              = azurerm_subnet.siemens_system_subnet.id
  vault_id               = "${data.azurerm_key_vault.nv-infra-core.id}"
  recovery_vault_name    = var.recovery_vault_name
  backup_policy_id       = var.backup_policy_id
  vm_size                = "Standard_D4s_v3"
  secondary_nic          = "${azurerm_network_interface.vms_secondary_nic.id}"
  availability_set       = azurerm_availability_set.nv_siemens_avs.id
  image_publisher        = "MicrosoftSQLServer"
  image_offer            = "SQL2016SP1-WS2016"
  image_sku              = "Enterprise"
  image_version          = "latest"
  managed_data_disk_size = "500"
}

# -- Sipass --
data "azurerm_key_vault_secret" "nv-siemens-sipass" {
  name         = "nv-siemens-sipass"
  key_vault_id = "${data.azurerm_key_vault.nv-infra-core.id}"
}

resource "azurerm_network_interface" "sipass_secondary_nic" {
  name                      = "sipass-second-nic"
  resource_group_name       = "${var.resource_group_name}"
  location                  = "${var.location}"
  network_security_group_id = "${azurerm_network_security_group.nv_siemens_nsg.id}"

  ip_configuration {
    name                          = "sipass-second-nic_config"
    subnet_id                     = azurerm_subnet.siemens_sipass_controllers.id
    private_ip_address_allocation = "static"
    private_ip_address            = "10.44.1.102"
  }
}

module "nv-siemens-sipass" {
  source                 = "../modules/windows-server"
  security_group_id      = "${azurerm_network_security_group.nv_siemens_nsg.id}"
  name                   = "sipass"
  ipaddress              = "10.44.1.137"
  password               = "${data.azurerm_key_vault_secret.nv-siemens-sipass.value}"
  location               = "${var.location}"
  resource_group_name    = "${var.resource_group_name}"
  subnet_id              = azurerm_subnet.siemens_system_subnet.id
  vault_id               = "${data.azurerm_key_vault.nv-infra-core.id}"
  recovery_vault_name    = var.recovery_vault_name
  backup_policy_id       = var.backup_policy_id
  vm_size                = "Standard_D2s_v3"
  managed_data_disk_size = "1000"
  secondary_nic          = "${azurerm_network_interface.sipass_secondary_nic.id}"
  availability_set       = azurerm_availability_set.nv_siemens_avs.id
  image_publisher        = "MicrosoftSQLServer"
  image_offer            = "SQL2016SP1-WS2016"
  image_sku              = "Enterprise"
  image_version          = "latest"
}

# -- Identity --
data "azurerm_key_vault_secret" "nv-siemens-identity" {
  name         = "nv-siemens-identity"
  key_vault_id = "${data.azurerm_key_vault.nv-infra-core.id}"
}

resource "azurerm_network_interface" "identity_secondary_nic" {
  name                      = "identity-second-nic"
  resource_group_name       = "${var.resource_group_name}"
  location                  = "${var.location}"
  network_security_group_id = "${azurerm_network_security_group.nv_siemens_nsg.id}"

  ip_configuration {
    name                          = "identity-second-nic_config"
    subnet_id                     = azurerm_subnet.siemens_sipass_controllers.id
    private_ip_address_allocation = "static"
    private_ip_address            = "10.44.1.103"
  }
}

module "nv-siemens-identity" {
  source                 = "../modules/windows-server"
  security_group_id      = "${azurerm_network_security_group.nv_siemens_nsg.id}"
  name                   = "identity"
  ipaddress              = "10.44.1.138"
  password               = "${data.azurerm_key_vault_secret.nv-siemens-identity.value}"
  location               = "${var.location}"
  resource_group_name    = "${var.resource_group_name}"
  subnet_id              = azurerm_subnet.siemens_system_subnet.id
  vault_id               = "${data.azurerm_key_vault.nv-infra-core.id}"
  recovery_vault_name    = var.recovery_vault_name
  backup_policy_id       = var.backup_policy_id
  vm_size                = "Standard_B8ms"
  managed_data_disk_size = "100"
  secondary_nic          = "${azurerm_network_interface.identity_secondary_nic.id}"
  availability_set       = azurerm_availability_set.nv_siemens_avs.id
}

# -- Recording server --
data "azurerm_key_vault_secret" "nv-siemens-recording-server" {
  name         = "nv-siemens-recording-server"
  key_vault_id = "${data.azurerm_key_vault.nv-infra-core.id}"
}

resource "azurerm_network_interface" "recording_secondary_nic" {
  name                      = "recording-second-nic"
  resource_group_name       = "${var.resource_group_name}"
  location                  = "${var.location}"
  network_security_group_id = "${azurerm_network_security_group.nv_siemens_nsg.id}"

  ip_configuration {
    name                          = "recording-second-nic_config"
    subnet_id                     = azurerm_subnet.siemens_cameras.id
    private_ip_address_allocation = "static"
    private_ip_address            = "10.44.1.44"
  }
}

module "nv-siemens-recording-server" {
  source                 = "../modules/windows-server"
  security_group_id      = "${azurerm_network_security_group.nv_siemens_nsg.id}"
  name                   = "recordingserver"
  ipaddress              = "10.44.1.139"
  password               = "${data.azurerm_key_vault_secret.nv-siemens-recording-server.value}"
  location               = "${var.location}"
  resource_group_name    = "${var.resource_group_name}"
  subnet_id              = azurerm_subnet.siemens_system_subnet.id
  vault_id               = "${data.azurerm_key_vault.nv-infra-core.id}"
  recovery_vault_name    = var.recovery_vault_name
  backup_policy_id       = var.backup_policy_id
  vm_size                = "Standard_D4s_v3"
  managed_data_disk_size = "500"
  secondary_nic          = "${azurerm_network_interface.recording_secondary_nic.id}"
  availability_set       = azurerm_availability_set.nv_siemens_avs.id
}

# -- SQL Server --
data "azurerm_key_vault_secret" "nv-siemens-sql" {
  name         = "nv-siemens-sql"
  key_vault_id = "${data.azurerm_key_vault.nv-infra-core.id}"
}

resource "azurerm_network_interface" "sql_secondary_nic" {
  name                      = "sql-second-nic"
  resource_group_name       = "${var.resource_group_name}"
  location                  = "${var.location}"
  network_security_group_id = "${azurerm_network_security_group.nv_siemens_nsg.id}"

  ip_configuration {
    name                          = "sql-second-nic_config"
    subnet_id                     = azurerm_subnet.siemens_system_subnet.id
    private_ip_address_allocation = "static"
    private_ip_address            = "10.44.1.141"
  }
}

module "nv-siemens-sql" {
  source                 = "../modules/windows-server"
  security_group_id      = "${azurerm_network_security_group.nv_siemens_nsg.id}"
  name                   = "sql"
  ipaddress              = "10.44.1.140"
  password               = "${data.azurerm_key_vault_secret.nv-siemens-sql.value}"
  location               = "${var.location}"
  resource_group_name    = "${var.resource_group_name}"
  subnet_id              = azurerm_subnet.siemens_system_subnet.id
  vault_id               = "${data.azurerm_key_vault.nv-infra-core.id}"
  recovery_vault_name    = var.recovery_vault_name
  backup_policy_id       = var.backup_policy_id
  vm_size                = "Standard_DS12_v2"
  managed_data_disk_size = "500"
  secondary_nic          = "${azurerm_network_interface.sql_secondary_nic.id}"
  availability_set       = azurerm_availability_set.nv_siemens_avs.id
  image_publisher        = "MicrosoftSQLServer"
  image_offer            = "SQL2016SP1-WS2016"
  image_sku              = "Enterprise"
  image_version          = "latest"
}
