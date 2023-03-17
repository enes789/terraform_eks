output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "sa_iam_role_arn" {
  description = "ARN of IAM role"
  value       = module.iam_eks_role.iam_role_arn
}
