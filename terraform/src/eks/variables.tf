# variable "environment" {
#   type        = string
#   description = "Name of the Environment (Stage-QA-Dev-Prod) being created"
#   default     = "dev"
# }

variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "vpc_id" {
  type        = string
  description = "VPC id"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnets that you want to create in your VPC"
}

variable "cluster_version" {
  type        = string
  default     = "1.25"
  description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.22`)"
}

variable "scaling_config" {
  description = "Settings for Node Scaling Config"
  type        = map(any)
  default = {
    desired_size = 1,
    max_size     = 1,
    min_size     = 1
  }
}

variable "instance_types" {
  type        = list(string)
  description = "Instance types of the Node group"
  default     = ["t3.medium"]
}

variable "namespace_service_accounts" {
  type        = list(any)
  description = "List of namespace:service account pairs"
  default     = ["default:app-sa"]
}

variable "manage_aws_auth_configmap" {
  type        = bool
  description = "Determines whether to manage the aws-auth configmap"
  default     = false
}

variable "aws_auth_roles" {
  type        = list(any)
  description = "List of role maps to add to the aws-auth configmap"
  default     = []
}

variable "aws_auth_users" {
  type        = list(any)
  description = "List of user maps to add to the aws-auth configmap"
  default     = []
}


variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
  default     = {}
}
