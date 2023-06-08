locals {
  environment = basename(get_parent_terragrunt_dir())
  tags = {
    environment   = basename(get_parent_terragrunt_dir())
    business-unit = "100 Digitalization AT - AB"
    department    = "100005 Digitalization Common - AB"
    cost-center   = "100005001 Digitalization Core - AB"
  }
}
