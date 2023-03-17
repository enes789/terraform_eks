environment = "test"
region      = "us-east-1"

vpc_id     = "vpc-d962cca4"
subnet_ids = ["subnet-d07d509d", "subnet-8622bdd9", "subnet-6c1c8e0a"]

manage_aws_auth_configmap = true

tags = {
  "Provisoner"  = "Terraform"
  "Environment" = "test"
}
