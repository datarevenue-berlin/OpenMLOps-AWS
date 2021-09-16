terraform {
  backend "s3" {
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "mlflow_artifact_root" {
  bucket = var.bucket_name
}

module "mlops-architecture-eks" {
  source = "./eks"
  cluster_name = var.cluster_name
  map_users = var.additional_aws_users
  aws_region = var.aws_region
  eks_worker_groups_az_a = var.eks_worker_groups_az_a
  eks_worker_groups_az_b = var.eks_worker_groups_az_b
  kubernetes_version = var.kubernetes_version
}
