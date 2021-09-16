output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.mlops-architecture-eks.cluster_security_group_id
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.mlops-architecture-eks.cluster_name
}

output "cluster_certificate" {
  value = module.mlops-architecture-eks.cluster_certificate
}

output "cluster_endpoint" {
  value = module.mlops-architecture-eks.cluster_endpoint
}

output "cluster_auth_token" {
  value = module.mlops-architecture-eks.cluster_auth_token
  sensitive = true
}

output "bucket_mlflow" {
  value = aws_s3_bucket.mlflow_artifact_root.bucket
}
