<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.22 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.10 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | 19.10.0 |
| <a name="module_iam_eks_role"></a> [iam\_eks\_role](#module\_iam\_eks\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.13.0 |
| <a name="module_iam_policy"></a> [iam\_policy](#module\_iam\_policy) | terraform-aws-modules/iam/aws//modules/iam-policy | 5.13.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_auth_roles"></a> [aws\_auth\_roles](#input\_aws\_auth\_roles) | List of role maps to add to the aws-auth configmap | `list(any)` | `[]` | no |
| <a name="input_aws_auth_users"></a> [aws\_auth\_users](#input\_aws\_auth\_users) | List of user maps to add to the aws-auth configmap | `list(any)` | `[]` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.22`) | `string` | `"1.25"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the Environment (Stage-QA-Dev-Prod) being created | `string` | `"dev"` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | Instance types of the Node group | `list(string)` | <pre>[<br>  "t3.medium"<br>]</pre> | no |
| <a name="input_manage_aws_auth_configmap"></a> [manage\_aws\_auth\_configmap](#input\_manage\_aws\_auth\_configmap) | Determines whether to manage the aws-auth configmap | `bool` | `false` | no |
| <a name="input_namespace_service_accounts"></a> [namespace\_service\_accounts](#input\_namespace\_service\_accounts) | List of namespace:service account pairs | `list(any)` | <pre>[<br>  "default:app-sa"<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | `"us-east-1"` | no |
| <a name="input_scaling_config"></a> [scaling\_config](#input\_scaling\_config) | Settings for Node Scaling Config | `map(any)` | <pre>{<br>  "desired_size": 1,<br>  "max_size": 1,<br>  "min_size": 1<br>}</pre> | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnets that you want to create in your VPC | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the EKS cluster |
| <a name="output_sa_iam_role_arn"></a> [sa\_iam\_role\_arn](#output\_sa\_iam\_role\_arn) | ARN of IAM role |
<!-- END_TF_DOCS -->