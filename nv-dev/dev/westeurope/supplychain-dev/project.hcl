locals {
  resource_group_name = basename(get_terragrunt_dir())
  tags = {
    owner         = "NVSupplyChain@northvolt.com"
    business-unit = "115 Supply Chain - AB"
    department    = "115048 Purchasing - AB"
    cost-center   = "115048033 Supply Chain Excellence & Scaling"
  }
}

