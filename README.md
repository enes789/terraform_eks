# Deploying Infrastructure Across Multiple Environments with Terraform Workspaces and Kubernetes deployment for EKS
This repository contains a Terraform module for creating an Amazon EKS cluster and IAM resources. It also includes instructions for deploying a Kubernetes pod that can access an S3 bucket using the IAM role created by Terraform.

## Prerequisites
Before using this module, you will need to have the following:

* An AWS account
* AWS CLI installed and configured with appropriate permissions
* Terraform installed on your local machine

## Usage
To use this module, follow these steps:

1. Clone the Git repository containing the Terraform code for your infrastructure.

2. Initialize the Terraform backend.

```
terraform init
```

3. Create a new Terraform workspace for the dev environment.

```
terraform workspace new dev
```

4. Deploy the infrastructure for the dev environment.

```
terraform apply -var-file="../..environments/dev.tfvars"
```

This command will create the infrastructure for the dev environment using the variables defined in the dev.tfvars file.

5. Create a new Terraform workspace for the prod environment.

```
terraform workspace new prod
```

6. Deploy the infrastructure for the staging environment.

```
terraform apply -var-file="../..environments/prod.tfvars"
```

This command will create the infrastructure for the staging environment using the variables defined in the staging.tfvars file.

7. Repeat steps 5 and 6 for any additional environments.

8. Create a Kubernetes deployment manifest that includes the `serviceAccountName` field with the name of the IAM role created in step 3 or use [deployment.yaml](./examples/deployment.yaml)
file (Make sure to change value of `eks.amazonaws.com/role-arn` annotation in ServiceAccount in this file).

9. To deploy a pod that can access the S3 bucket, you will need to first authenticate with the EKS cluster. To do this, run the following command:

```
aws eks update-kubeconfig --name <EKS_CLUSTER_NAME> --region <AWS_REGION>
```

This command will update your `kubeconfig` file with the credentials needed to access the EKS cluster. Make sure your user/role in `aws-auth` configmap

10. Now that you are authenticated, you can deploy the Kubernetes pod by applying the deployment manifest that you created in step 4

```
kubectl apply -f deployment.yaml
```

This command will deploy a pod that has the IAM role assigned, allowing it to access the S3 bucket.
