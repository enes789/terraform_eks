# Terraform and Kubernetes deployment for EKS
This repository contains a Terraform module for creating an Amazon EKS cluster and IAM resources. It also includes instructions for deploying a Kubernetes pod that can access an S3 bucket using the IAM role created by Terraform.

## Prerequisites
Before using this module, you will need to have the following:

* An AWS account
* AWS CLI installed and configured with appropriate permissions
* Terragrunt installed on your local machine.

## Usage
To use this module, follow these steps:

1. Clone the Terraform repository

2. Navigate to the directory containing the Terragrunt code.

```
cd terraform/environments/dev/eks
```

3. Run the following commands to create the EKS cluster and IAM resources:

```
terragrunt init
terragrunt plan
terragrunt apply
```
* Optional: The run-all command

To be able to deploy multiple Terraform modules in a single command, use below commands.

```
cd terraform/environments/dev
terragrunt run-all plan
terragrunt run-all apply
```

4. Create a Kubernetes deployment manifest that includes the `serviceAccountName` field with the name of the IAM role created in step 3 or use [deployment.yaml](./examples/deployment.yaml)
file (Make sure to change value of `eks.amazonaws.com/role-arn` annotation in ServiceAccount in this file).

5. To deploy a pod that can access the S3 bucket, you will need to first authenticate with the EKS cluster. To do this, run the following command:

```
aws eks update-kubeconfig --name <EKS_CLUSTER_NAME> --region <AWS_REGION>
```

This command will update your `kubeconfig` file with the credentials needed to access the EKS cluster. Make sure your user/role in `aws-auth` configmap

5. Now that you are authenticated, you can deploy the Kubernetes pod by applying the deployment manifest that you created in step 4

```
kubectl apply -f deployment.yaml
```

This command will deploy a pod that has the IAM role assigned, allowing it to access the S3 bucket.
