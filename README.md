# MLOps Reference Architecture deployed on AWS

This repository contains Terraform configuration which serves as an example of how to deploy
[MLOps architecture][mlops-repo] on an EKS cluster. 

## Other repositories

![Repositories diagram](http://www.plantuml.com/plantuml/svg/fP91Qp8n48Rl-HKlNhvJtBjy5ANqK6nfmK8FuY4cenlCJfRCn1vA_tkn8aZPMehNmCpxpFDcAkgArYuPdvm8HeyFJxrWLdmRbRpMGiYCsUjYX7S3F9UyZn8p2nnygg9Ku3WWigXBIN1Se3ad6HjWkMnLUvaqpJPgMzTZdxicE7M5ziILx9fAYjnqAVTYtLckpMpTco15tc6rCX-6in8IRTIyj55GgC-6EE3mRdu-u4X-Fm28o72OrpKL9YKvNNGT-1dn1QjtymLkZt7VrGuoeKhaxTUOKDb7JyYRGp5NMgQTs5F46RYvz1F-Mpie-Wz3moBCFytmcRNa16q9kGGg4pFOgbssCGJYrStlUqqR0y77uXEPAN6eNVe4)

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

## Accessing the tools

The tools are configured in the most basic way. For details on how to change the configuration, please refer 
to the [MLOps reference architecture][mlops-repo] documentation.

### Jupyterhub

The default password is `a-shared-secret-password`.

## Provisioned resources

Please refer to [this repository](https://github.com/datarevenue-berlin/mlops-architecture-eks-cluster)'s Readme
to learn what resources will be provisioned.

An S3 bucket will be provisioned as a storage backend.

MLOps tools will be installed in the cluster.

## Structure

Two Terraform modules are used:
- [`mlops-architecture-eks-cluster`][mlops-eks-repo] 
  to provision a Kubernetes cluster using EKS service of AWS,
- [`mlops-architecture`][mlops-repo] 
  to install MLOps tools in the cluster.
  
Please refer to the documentation of the modules for the details. 


[mlops-repo]: https://github.com/datarevenue-berlin/mlops-architecture
[mlops-eks-repo]: https://github.com/datarevenue-berlin/mlops-architecture-eks-cluster
