# MLOps Reference Architecture deployed on AWS

This repository contains Terraform configuration which serves as a base infrastructure to deploy
[MLOps architecture][mlops-repo] on an EKS cluster. 

## Prerequisites

To use this configuration, you must have [Terraform](https://www.terraform.io/downloads.html) installed at version 0.14 or newer.

You must also have an [AWS account](https://portal.aws.amazon.com/billing/signup#/start).

ATTENTION: Applying this configuration will result in AWS billing you for the provisioned resources.

## Installation

1. Edit `my_vars.tfvars` file. Set values for the variables mentioned there.
1. `cd` into the root of this repository.
1. Set up access to your AWS account, best by [setting environment variables](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html).
1. Run `terraform apply -var-file my_vars.tfvars`. Review the plan that Terraform produces.
1. If you are okay with the plan, answer `yes`. Terraform will provision the cluster and install MLOps tools in it.

## Installing the tools

After installing the infrastructure, MLOPs tools can be installed. Please refer 
to the [MLOps reference architecture][mlops-repo] documentation. See `output.tf` for the outputs that may be needed 
to deploy the applications.

## Provisioned resources

This configuration will provision:
- an S3 bucket as a storage backend.
- a VPC to isolate the cluster resources
- an EKS cluster with one node group
- security groups needed for the tools to communicate with each other and with the outside world
- a policy to allow the worker nodes access to S3 storage and ECR registry
