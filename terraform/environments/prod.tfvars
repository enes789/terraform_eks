# environment = "prod"
region      = "us-east-1"

vpc_id     = "vpc-d962cca4" # chnage for prod
subnet_ids = ["subnet-d07d509d", "subnet-8622bdd9", "subnet-6c1c8e0a"] # chnage for prod

manage_aws_auth_configmap = true

tags = {
  "Provisoner"  = "Terraform"
  "Environment" = "prod"
}
