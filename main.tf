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
  // TODO: Use the HTTPS source once we publish the repository.
//  source = "github.com/datarevenue-berlin/mlops-architecture-eks-cluster.git"  // HTTPS
//  source = "git@github.com:datarevenue-berlin/mlops-architecture-eks-cluster.git"  // SSH
  source = "../OpenMLOps-EKS-cluster"  // local

  cluster_name = var.cluster_name
  map_users = var.additional_aws_users
  aws_region = var.aws_region
  eks_worker_groups = var.eks_worker_groups
  kubernetes_version = var.kubernetes_version
}


provider "helm" {
  kubernetes {
    host                   = module.mlops-architecture-eks.cluster_endpoint
    token                  = module.mlops-architecture-eks.cluster_auth_token
    cluster_ca_certificate = base64decode(module.mlops-architecture-eks.cluster_certificate)
  }
}

provider "kubernetes" {
  host                   = module.mlops-architecture-eks.cluster_endpoint
  token                  = module.mlops-architecture-eks.cluster_auth_token
  cluster_ca_certificate = base64decode(module.mlops-architecture-eks.cluster_certificate)
}


module "mlops-architecture" {
  // TODO: Use the HTTPS source once we publish the repository.
  //  source = "github.com/datarevenue-berlin/mlops-architecture.git"  // HTTPS
  //  source = "git@github.com:datarevenue-berlin/mlops-architecture.git"  // SSH
  source = "../OpenMLOps"  // local

  // Necessary for the correct order of destruction.
  depends_on = [module.mlops-architecture-eks]

  db_username = var.db_username
  db_password = var.db_password
  mlflow_artifact_root = "s3://${aws_s3_bucket.mlflow_artifact_root.bucket}"
  mlflow_service_type = "ClusterIP"

  prefect_service_type = "ClusterIP"
  // Check the documentation to learn how to generate a token. E.g.: `openssl rand -hex 32`
  jupyter_dummy_password = var.jupyter_dummy_password
  jhub_proxy_secret_token = "IfYouDecideToUseJhubProxyYouShouldChangeThisValueToARandomString"
  jhub_proxy_service_type = "ClusterIP"

  protocol = var.protocol
  hostname = var.hostname
  oauth2_providers = var.oauth2_providers
  ory_kratos_cookie_secret = var.ory_kratos_cookie_secret
  ory_kratos_db_password = var.ory_kratos_db_password

  install_feast = var.install_feast

  aws = true
  enable_registration_page = var.enable_registration_page
  tls_certificate_arn = var.tls_certificate_arn

  access_rules_path = var.access_rules_path
}
