terraform {
  backend "local" {
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
  source = "../mlops-architecture-eks-cluster"  // local

  cluster_name = var.cluster_name
  map_users = var.additional_aws_users
  aws_region = var.aws_region
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
  source = "../mlops-architecture"  // local

  // Necessary for the correct order of destruction.
  depends_on = [module.mlops-architecture-eks]

  db_username = var.db_username
  db_password = var.db_password
  mlflow_artifact_root = "s3://${aws_s3_bucket.mlflow_artifact_root.bucket}"
  mlflow_service_type = "ClusterIP"

  prefect_service_type = "ClusterIP"
  // Check the documentation to learn how to generate a token. E.g.: `openssl rand -hex 32`
  jhub_proxy_secret_token = "IfYouDecideToUseJhubProxyYouShouldChangeThisValueToARandomString"
  jhub_proxy_service_type = "ClusterIP"

  protocol = var.protocol
  hostname = var.hostname
  oauth2_providers = var.oauth2_providers
  ory_kratos_cookie_secret = var.ory_kratos_cookie_secret
  ory_kratos_db_password = var.ory_kratos_db_password

  install_feast = var.install_feast

  aws = true
  enable_registration = var.enable_registration
  tls_certificate_arn = var.tls_certificate_arn
}
