output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.eks.cluster_security_group_id
}

output "worker_iam_role_name" {
  description = "Worker IAM role name. Allow parent modules to attach other policies to the workers"
  value = module.eks.worker_iam_role_name
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = var.cluster_name
}

output "cluster_certificate" {
  value = data.aws_eks_cluster.cluster.certificate_authority.0.data
}

output "cluster_endpoint" {
  value = data.aws_eks_cluster.cluster.endpoint
}

output "cluster_auth_token" {
  value = data.aws_eks_cluster_auth.cluster.token
  sensitive = true
}
