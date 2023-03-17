module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.10.0"

  cluster_name    = "${var.environment}-eks"
  cluster_version = var.cluster_version

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  eks_managed_node_groups = {
    test = {
      min_size     = "${var.scaling_config["min_size"]}"
      max_size     = "${var.scaling_config["max_size"]}"
      desired_size = "${var.scaling_config["desired_size"]}"

      instance_types = "${var.instance_types}"
    }
  }

  # aws-auth configmap
  manage_aws_auth_configmap = var.manage_aws_auth_configmap
  aws_auth_roles            = var.aws_auth_roles
  aws_auth_users            = var.aws_auth_users

  tags = var.tags
}

module "iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.13.0"

  name        = "${var.environment}-s3-sa-policy"
  path        = "/"
  description = "Allow the Pods in EKS to read the S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:ListAllMyBuckets",
          "s3:GetObject"
        ]
        Resource = [
          "arn:aws:s3:::*"
        ]
      }
    ]
  })

  tags = var.tags

}

module "iam_eks_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.13.0"

  role_name = "${var.environment}-eks-sa-role"
  role_policy_arns = {
    policy = "${module.iam_policy.arn}"
  }

  oidc_providers = {
    one = {
      provider_arn               = "${module.eks.oidc_provider_arn}"
      namespace_service_accounts = "${var.namespace_service_accounts}"
    }
  }

  tags = var.tags
}
