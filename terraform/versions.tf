terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.22"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.10"
    }
  }

  backend "s3" {
    bucket         = "terraform-states-759037523915-us-east-1"
    key            = "terraform.tfstate"
    dynamodb_table = "terraform-states-759037523915-us-east-1-lock"
    region         = "us-east-1"
  }
}

