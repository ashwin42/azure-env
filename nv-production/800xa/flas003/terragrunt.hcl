terraform {
  source = "git::git@github.com:northvolt/tf-mod-azure.git//800xA_vm?ref=v0.1.0"
  #source = "../modules/800xA_vm"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "global" {
  config_path = "../global"
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  name                    = "FLAS003"
  ipaddress               = "10.60.60.13"
  vm_size                 = "Standard_B2MS"
  resource_group_name     = dependency.global.outputs.resource_group.name
  resource_group_name_alt = "800XA"
  resource_group_name_vm  = "800XA"
  subnet_id               = dependency.global.outputs.subnet_2.id
  default_tags            = { repo = "azure-env/nv-production/800xa/flas003" }
  managed_disk_name       = "-OS-ManagedDisk-FromSnapshot"
  managed_disk_type       = "StandardSSD_LRS"
}

