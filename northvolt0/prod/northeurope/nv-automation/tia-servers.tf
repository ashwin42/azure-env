# Template to update the base image
# module "tia-template" {
#   source              = "../../../modules/tia-server/"
#   name                = "template"
#   ipaddress           = "10.101.2.245"
#   password            = "xq2!%5N&Vkz6YiaT"
#   location            = "${var.location}"
#   resource_group_name = "${var.resource_group_name}"
#   subnet_id           = "${local.nv_automation_1}"
#   #vault_id            = "${data.azurerm_key_vault.nv_core.id}"
#   recovery_vault_name = "${data.terraform_remote_state.nv-shared.recovery_services.recovery_vault_name}"
#   backup_policy_id    = "${data.terraform_remote_state.nv-shared.recovery_services.protection_policy_daily_id}"
# }

# -- Northvolt --
data "azurerm_key_vault_secret" "tia_northvolt" {
  name         = "tia-northvolt-nvadmin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

module "tia_northvolt" {
  source                = "../../../modules/tia-server/"
  name                  = "northvolt"
  ipaddress             = "10.101.2.210"
  password              = data.azurerm_key_vault_secret.tia_northvolt.value
  location              = var.location
  resource_group_name   = var.resource_group_name
  subnet_id             = local.nv_automation_1
  dns_zone              = azurerm_dns_zone.tia_nvlt_co.name
  vault_id              = data.azurerm_key_vault.nv_core.id
  recovery_vault_name   = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  backup_policy_id      = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
  public_ipaddress      = true
  public_ipaddress_name = "tia1-nic_config_public"
  subscription_id       = var.subscription_id
}

# -- Zeppelin --
data "azurerm_key_vault_secret" "tia_zeppelin" {
  name         = "tia-zeppelin-nvadmin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

module "tia_zeppelin" {
  source              = "../../../modules/tia-server/"
  name                = "zeppelin"
  ipaddress           = "10.101.2.201"
  password            = data.azurerm_key_vault_secret.tia_zeppelin.value
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.nv_automation_1
  dns_zone            = azurerm_dns_zone.tia_nvlt_co.name
  vault_id            = data.azurerm_key_vault.nv_core.id
  recovery_vault_name = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  backup_policy_id    = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
  subscription_id     = var.subscription_id
}

# -- CIS --
data "azurerm_key_vault_secret" "tia_cis" {
  name         = "tia-cis-nvadmin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

module "tia_cis" {
  source              = "../../../modules/tia-server/"
  name                = "cis"
  ipaddress           = "10.101.2.202"
  password            = data.azurerm_key_vault_secret.tia_cis.value
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.nv_automation_1
  dns_zone            = azurerm_dns_zone.tia_nvlt_co.name
  vault_id            = data.azurerm_key_vault.nv_core.id
  recovery_vault_name = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  backup_policy_id    = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
  subscription_id     = var.subscription_id
}

# -- Dürr --
data "azurerm_key_vault_secret" "tia_durr" {
  name         = "tia-durr-nvadmin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

module "tia_durr" {
  source              = "../../../modules/tia-server/"
  name                = "durr"
  ipaddress           = "10.101.2.203"
  password            = data.azurerm_key_vault_secret.tia_durr.value
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.nv_automation_1
  dns_zone            = azurerm_dns_zone.tia_nvlt_co.name
  vault_id            = data.azurerm_key_vault.nv_core.id
  recovery_vault_name = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  backup_policy_id    = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
  ad_join             = "true"
  subscription_id     = var.subscription_id
}

# -- Kova --
data "azurerm_key_vault_secret" "tia_kova" {
  name         = "tia-kova-nvadmin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

module "tia_kova" {
  source              = "../../../modules/tia-server/"
  name                = "kova"
  ipaddress           = "10.101.2.204"
  password            = data.azurerm_key_vault_secret.tia_kova.value
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.nv_automation_1
  dns_zone            = azurerm_dns_zone.tia_nvlt_co.name
  vault_id            = data.azurerm_key_vault.nv_core.id
  recovery_vault_name = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  backup_policy_id    = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
  subscription_id     = var.subscription_id
}

# -- nvdev --
data "azurerm_key_vault_secret" "tia_nvdev" {
  name         = "tia-nvdev-nvadmin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

module "tia_nvdev" {
  source              = "../../../modules/tia-server/"
  name                = "nvdev"
  ipaddress           = "10.101.2.205"
  password            = data.azurerm_key_vault_secret.tia_nvdev.value
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.nv_automation_1
  dns_zone            = azurerm_dns_zone.tia_nvlt_co.name
  vault_id            = data.azurerm_key_vault.nv_core.id
  recovery_vault_name = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  backup_policy_id    = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
  subscription_id     = var.subscription_id
}

# -- Jeil --
data "azurerm_key_vault_secret" "tia_jeil" {
  name         = "tia-jeil-nvadmin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

module "tia_jeil" {
  source              = "../../../modules/tia-server/"
  name                = "jeil"
  ipaddress           = "10.101.2.206"
  password            = data.azurerm_key_vault_secret.tia_jeil.value
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.nv_automation_1
  dns_zone            = azurerm_dns_zone.tia_nvlt_co.name
  vault_id            = data.azurerm_key_vault.nv_core.id
  recovery_vault_name = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  backup_policy_id    = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
  subscription_id     = var.subscription_id
}

# -- Siemens bms --
data "azurerm_key_vault_secret" "tia_siemensbms" {
  name         = "tia-siemensbms-nvadmin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

module "tia_siemensbms" {
  source              = "../../../modules/tia-server/"
  name                = "siemensbms"
  ipaddress           = "10.101.2.207"
  password            = data.azurerm_key_vault_secret.tia_siemensbms.value
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.nv_automation_1
  dns_zone            = azurerm_dns_zone.tia_nvlt_co.name
  vault_id            = data.azurerm_key_vault.nv_core.id
  recovery_vault_name = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  backup_policy_id    = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
  subscription_id     = var.subscription_id
}

# -- Seci --
data "azurerm_key_vault_secret" "tia_seci" {
  name         = "tia-seci-nvadmin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

module "tia_seci" {
  source              = "../../../modules/tia-server/"
  name                = "seci"
  ipaddress           = "10.101.2.208"
  password            = data.azurerm_key_vault_secret.tia_seci.value
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.nv_automation_1
  dns_zone            = azurerm_dns_zone.tia_nvlt_co.name
  vault_id            = data.azurerm_key_vault.nv_core.id
  recovery_vault_name = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  backup_policy_id    = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
  ad_join             = true
  subscription_id     = var.subscription_id
}

# [TOC-320] -- Fluor --
data "azurerm_key_vault_secret" "tia_fluor" {
  name         = "tia-fluor-nvadmin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

module "tia_fluor" {
  source              = "../../../modules/tia-server/"
  name                = "fluor"
  ipaddress           = "10.101.2.209"
  password            = data.azurerm_key_vault_secret.tia_fluor.value
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.nv_automation_1
  dns_zone            = azurerm_dns_zone.tia_nvlt_co.name
  vault_id            = data.azurerm_key_vault.nv_core.id
  recovery_vault_name = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  backup_policy_id    = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
  ad_join             = true
  subscription_id     = var.subscription_id
}

# -- Sejong --
data "azurerm_key_vault_secret" "tia_sejong" {
  name         = "tia-sejong-nvadmin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

module "tia_sejong" {
  source              = "../../../modules/tia-server/"
  name                = "sejong"
  ipaddress           = "10.101.2.211"
  password            = data.azurerm_key_vault_secret.tia_sejong.value
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.nv_automation_1
  dns_zone            = azurerm_dns_zone.tia_nvlt_co.name
  vault_id            = data.azurerm_key_vault.nv_core.id
  recovery_vault_name = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  backup_policy_id    = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
  ad_join             = true
  subscription_id     = var.subscription_id
}

# -- Flexlink --
data "azurerm_key_vault_secret" "tia_flexlink" {
  name         = "tia-flexlink-nvadmin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

module "tia_flexlink" {
  source              = "../../../modules/tia-server/"
  name                = "flexlink"
  ipaddress           = "10.101.2.212"
  password            = data.azurerm_key_vault_secret.tia_flexlink.value
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.nv_automation_1
  dns_zone            = azurerm_dns_zone.tia_nvlt_co.name
  vault_id            = data.azurerm_key_vault.nv_core.id
  recovery_vault_name = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  backup_policy_id    = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
  ad_join             = true
  subscription_id     = var.subscription_id
}

# -- Tronrud --
data "azurerm_key_vault_secret" "tia_tronrud" {
  name         = "tia-tronrud-nvadmin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

module "tia_tronrud" {
  source              = "../../../modules/tia-server/"
  name                = "tronrud"
  ipaddress           = "10.101.2.213"
  password            = data.azurerm_key_vault_secret.tia_tronrud.value
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.nv_automation_1
  dns_zone            = azurerm_dns_zone.tia_nvlt_co.name
  vault_id            = data.azurerm_key_vault.nv_core.id
  recovery_vault_name = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  backup_policy_id    = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
  ad_join             = true
  subscription_id     = var.subscription_id
}

# -- Siemens --
data "azurerm_key_vault_secret" "tia_siemens" {
  name         = "tia-siemens-nvadmin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

module "tia_siemens" {
  source              = "../../../modules/tia-server/"
  name                = "siemens"
  ipaddress           = "10.101.2.214"
  password            = data.azurerm_key_vault_secret.tia_siemens.value
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.nv_automation_1
  dns_zone            = azurerm_dns_zone.tia_nvlt_co.name
  vault_id            = data.azurerm_key_vault.nv_core.id
  recovery_vault_name = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  backup_policy_id    = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
  ad_join             = true
  subscription_id     = var.subscription_id
}

# -- Comau --
data "azurerm_key_vault_secret" "tia_comau" {
  name         = "tia-comau-nvadmin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

module "tia_comau" {
  source              = "../../../modules/tia-server/"
  name                = "comau"
  ipaddress           = "10.101.2.215"
  password            = data.azurerm_key_vault_secret.tia_comau.value
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.nv_automation_1
  dns_zone            = azurerm_dns_zone.tia_nvlt_co.name
  vault_id            = data.azurerm_key_vault.nv_core.id
  recovery_vault_name = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  backup_policy_id    = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
  ad_join             = true
  subscription_id     = var.subscription_id
}

# -- Engie --
data "azurerm_key_vault_secret" "tia_engie" {
  name         = "tia-engie-nvadmin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

module "tia_engie" {
  source              = "../../../modules/tia-server/"
  name                = "engie"
  ipaddress           = "10.101.2.216"
  password            = data.azurerm_key_vault_secret.tia_engie.value
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.nv_automation_1
  dns_zone            = azurerm_dns_zone.tia_nvlt_co.name
  vault_id            = data.azurerm_key_vault.nv_core.id
  recovery_vault_name = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  backup_policy_id    = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
  ad_join             = true
  subscription_id     = var.subscription_id
}

# -- Titans --
data "azurerm_key_vault_secret" "tia_titans" {
  name         = "tia-titans-nvadmin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

module "tia_titans" {
  source              = "../../../modules/tia-server/"
  name                = "titans"
  ipaddress           = "10.101.2.217"
  password            = data.azurerm_key_vault_secret.tia_titans.value
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.nv_automation_1
  dns_zone            = azurerm_dns_zone.tia_nvlt_co.name
  vault_id            = data.azurerm_key_vault.nv_core.id
  recovery_vault_name = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  backup_policy_id    = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
  ad_join             = true
  subscription_id     = var.subscription_id
}

# [TOC-334] -- Wuxi --
data "azurerm_key_vault_secret" "tia_wuxi" {
  name         = "tia-wuxi-nvadmin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

module "tia_wuxi" {
  source              = "../../../modules/tia-server/"
  name                = "wuxi"
  ipaddress           = "10.101.2.218"
  password            = data.azurerm_key_vault_secret.tia_wuxi.value
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.nv_automation_1
  dns_zone            = azurerm_dns_zone.tia_nvlt_co.name
  vault_id            = data.azurerm_key_vault.nv_core.id
  recovery_vault_name = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  backup_policy_id    = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
  ad_join             = true
  subscription_id     = var.subscription_id
}

# [TOC-347] -- Cajo --
data "azurerm_key_vault_secret" "tia_cajo" {
  name         = "tia-cajo-nvadmin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

module "tia_cajo" {
  source              = "../../../modules/tia-server/"
  name                = "cajo"
  ipaddress           = "10.101.2.219"
  password            = data.azurerm_key_vault_secret.tia_cajo.value
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.nv_automation_1
  dns_zone            = azurerm_dns_zone.tia_nvlt_co.name
  vault_id            = data.azurerm_key_vault.nv_core.id
  recovery_vault_name = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  backup_policy_id    = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
  ad_join             = true
  subscription_id     = var.subscription_id
}

# [TOC-462] -- Sejfo --
data "azurerm_key_vault_secret" "tia_sejfo" {
  name         = "tia-sejfo-nvadmin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

module "tia_sejfo" {
  source              = "../../../modules/tia-server/"
  name                = "sejfo"
  ipaddress           = "10.101.2.220"
  password            = data.azurerm_key_vault_secret.tia_sejfo.value
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.nv_automation_1
  dns_zone            = azurerm_dns_zone.tia_nvlt_co.name
  vault_id            = data.azurerm_key_vault.nv_core.id
  recovery_vault_name = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  backup_policy_id    = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
  ad_join             = true
  subscription_id     = var.subscription_id
}

/*
# [TOC-470] -- mplus --
data "azurerm_key_vault_secret" "tia_mplus" {
  name         = "tia-mplus-nvadmin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

module "tia_mplus" {
  source              = "../../../modules/tia-server/"
  name                = "mplus"
  ipaddress           = "10.101.2.222"
  password            = data.azurerm_key_vault_secret.tia_mplus.value
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.nv_automation_1
  dns_zone            = azurerm_dns_zone.tia_nvlt_co.name
  vault_id            = data.azurerm_key_vault.nv_core.id
  recovery_vault_name = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  backup_policy_id    = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
  ad_join             = true
  subscription_id     = var.subscription_id
}


# [TOC-470] -- pne --
data "azurerm_key_vault_secret" "tia_pne" {
  name         = "tia-pne-nvadmin"
  key_vault_id = data.azurerm_key_vault.nv_core.id
}

module "tia_pne" {
  source              = "../../../modules/tia-server/"
  name                = "pne"
  ipaddress           = "10.101.2.223"
  password            = data.azurerm_key_vault_secret.tia_pne.value
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.nv_automation_1
  dns_zone            = azurerm_dns_zone.tia_nvlt_co.name
  vault_id            = data.azurerm_key_vault.nv_core.id
  #vault_id            = ""
  recovery_vault_name = data.terraform_remote_state.nv-shared.outputs.recovery_services.recovery_vault_name
  backup_policy_id    = data.terraform_remote_state.nv-shared.outputs.recovery_services.protection_policy_daily_id
  ad_join             = ""
  subscription_id     = var.subscription_id
}
*/