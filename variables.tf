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
}