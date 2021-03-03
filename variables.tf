variable "aws_region" {
  description = "AWS region"
  default = "eu-west-1"
}

variable "cluster_name" {
  description = "The name of your EKS cluster"
}

variable "bucket_name" {
  description = "The name of S3 bucket. Must be GLOBALLY unique!"
}

variable "db_username" {
  description = "Database username"
}

variable "db_password" {
  description = "Database password"
  sensitive   = true
}

variable "additional_aws_users" {
  description = "Additional AWS users that will have access to the cluster (e.g. your coworkers)."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)  // e.g. ["system:masters"]
  }))
  default = []
}
