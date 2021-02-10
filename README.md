# Data Revenue - MLOps Reference Architecture deployed on AWS

This repository contains Terraform configuration which serves as an example of how to deploy
MLOps architecture on an EKS cluster. 

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

## Provisioned resources

This configuration will provision:
- a VPC to isolate the cluster resources
- an EKS cluster with one node group
- security groups needed for the tools to communicate with each other and with the outside world
- a policy to allow the worker nodes access to S3 storage and ECR registry
- an S3 bucket as a storage backend

MLOps tools will be installed in the cluster.

## Structure

Two Terraform modules are used:
- [`mlops-architecture-eks-cluster`](https://github.com/datarevenue-berlin/mlops-architecture-eks-cluster) 
  to provision a Kubernetes cluster using EKS service of AWS,
- [`mlops-architecture`](https://github.com/datarevenue-berlin/mlops-architecture) 
  to install MLOps tools in the cluster.
  
Please refer to the documentation of the modules for the details. 
