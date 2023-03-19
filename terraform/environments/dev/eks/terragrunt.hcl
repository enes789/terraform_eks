# Include the root `terragrunt.hcl` configuration. The root configuration contains settings that are common across all
# components and environments, such as how to configure remote state.
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  base_source_url = include.root.locals.base_source_url
  module_name     = "eks"
  module_version  = "0.1"
}

terraform {
  source = "${local.base_source_url}//${local.module_name}?ref=${local.module_version}"
}

inputs = {
  vpc_id     = "vpc-d962cca4"
  subnet_ids = ["subnet-d07d509d", "subnet-8622bdd9", "subnet-6c1c8e0a"]

  manage_aws_auth_configmap = true

  tags = {
    "ModuleName"    = local.module_name
    "ModuleVersion" = local.module_version
    "Provisioner"   = "Terraform"
    "Environment"   = include.root.locals.environment_vars.locals.environment
  }
}