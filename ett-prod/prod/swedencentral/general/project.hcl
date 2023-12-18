locals {
  resource_group_name = "${basename(dirname(dirname(dirname(get_terragrunt_dir()))))}-general-rg"
  tags = {
    business-unit        = "109 Digitalization IT - AB"
    department           = "109037 IT Common - AB"
    cost-center          = "109037064 IT Common - AB"
    infrastructure-owner = "techops@northvolt.com"
  }
}

