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

variable "ory_kratos_db_password"{
  description = "PostgreSQL Database Password"
}

variable "ory_kratos_cookie_secret" {
  description = "Session Cookie Generation secret"
  sensitive = true
}

variable "oauth2_providers" {
  //  Configure multiple Oauth2 providers.
  //  example:
  //  [{
  //    provider = github
  //    client_id = change_me
  //    client_secret = change_me
  //    tenant = null
  //  }]
  //  If you're using GitHub, Google or Facebook, tenant won't be needed, so please set
  //  it as null or an empty string. It is required for AzureAd
  type = list(object({
    provider = string
    client_id = string
    client_secret = string
    tenant = string
  }))
  description = "OAuth2 Providers credentials"
}

variable "hostname" {
  description = "Hostname where the cluster can be accessible"
}

variable "protocol" {
  default = "https"
}

variable "install_feast" {
  type = bool
}

variable "tls_certificate_arn" {
}

variable "show_auth_ui" {
  type = bool
}