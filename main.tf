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
  source = "/home/mdank/repos/mlops/mlops-architecture-eks-cluster"  // local

  cluster_name = var.cluster_name
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
  source = "/home/mdank/repos/mlops/mlops-architecture"  // local

  // Necessary for the correct order of destruction.
  depends_on = [module.mlops-architecture-eks]

  db_username = var.db_username
  db_password = var.db_password
  mlflow_artifact_root = "s3://${aws_s3_bucket.mlflow_artifact_root.bucket}"

  // Check the documentation to learn how to generate a token. E.g.: `openssl rand -hex 32`
  jhub_proxy_secret_token = "IfYouDecideToUseJhubProxyYouShouldChangeThisValueToARandomString"
}
