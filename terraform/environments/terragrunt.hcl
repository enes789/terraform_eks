# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

locals {

  # Module Source
  base_source_url = "${path_relative_from_include()}/../src"

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract the variables we need for easy access
  aws_iam_role = "arn:aws:iam::${local.account_id}:role/TerraformExecutionRole"
  account_id   = local.environment_vars.locals.aws_account_id
  aws_region   = local.environment_vars.locals.region

}

#terragrunt will use these to assume a role before executing terraform
iam_role = local.aws_iam_role

# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "skip"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"

}
EOF
}

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "${local.environment_vars.locals.remote_state_bucket}-${local.account_id}-${local.environment_vars.locals.remote_state_region}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.environment_vars.locals.remote_state_region
    dynamodb_table = "${local.environment_vars.locals.remote_state_bucket}-${local.account_id}-${local.environment_vars.locals.remote_state_region}-lock"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.

inputs = merge(
  local.environment_vars.locals
)