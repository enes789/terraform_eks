
locals {
  environment    = "dev"
  aws_account_id = "759037523915" # TODO: replace me with your AWS account ID!

  remote_state_lock_table = "terraform-states"
  remote_state_bucket     = "terraform-states"
  remote_state_region     = "us-east-1"

  region = "us-east-1"
}


