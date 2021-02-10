module "eks-mlops" {
  // TODO: Use the HTTPS source once we publish the repository.
//  source = "github.com/datarevenue-berlin/mlops-architecture-eks-cluster.git"  // HTTPS
//  source = "git@github.com:datarevenue-berlin/mlops-architecture-eks-cluster.git"  // SSH
  source = "/home/mdank/repos/mlops-architecture-eks-cluster"  // local

  cluster_name = var.cluster_name
  map_users = []
}

resource "aws_s3_bucket" "mlflow_artifact_root" {
  bucket = var.bucket_name
}


module "mlops-architecture" {
  // TODO: Use the HTTPS source once we publish the repository.
//  source = "github.com/datarevenue-berlin/mlops-architecture.git"  // HTTPS
//  source = "git@github.com:datarevenue-berlin/mlops-architecture.git"  // SSH
  source = "/home/mdank/repos/mlops-architecture"  // local

  kubernetes = {
    host                   = module.eks-mlops.cluster_endpoint
    token                  = module.eks-mlops.cluster_auth_token
    cluster_ca_certificate = base64decode(module.eks-mlops.cluster_certificate)
  }

  db_username = var.db_username
  db_password = var.db_password
  mlflow_artifact_root = "s3://${aws_s3_bucket.mlflow_artifact_root.bucket}"
}
