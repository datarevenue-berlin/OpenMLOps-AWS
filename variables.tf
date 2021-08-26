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

variable "jupyter_dummy_password"{
  description = "Jupyter Hub Password"
}

variable "ory_kratos_db_password"{
  description = "Kratos PostgreSQL Database Password"
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

variable "enable_registration_page" {
  description = "Bool to set if registration page will or not be visible to users"
  type = bool
  default = true
}

variable "smtp_connection_uri" {
  description = "SMTP Connection for Ory"
  type = string
  default = "smtp://omigamibot%40gmail.com:omigamidevbot2021@smtp.gmail.com:587"
}

variable "smtp_from_address" {
  description = "Email address for outgoing mails from Ory"
  type = string
  default = "omigamibot@gmail.com"
}

variable "enable_password_recovery" {
  description = "Bool to set to enable password recovery using emails"
  type = bool
  default = false
}

variable "enable_verification" {
  description = "Bool to set to enable account registration confirmation using emails"
  type = bool
  default = false
}

variable "eks_worker_groups" {
  description = "Definition of AWS worker groups to be utilized."
  type = list(object({
    name = string
    instance_type = string
    additional_userdata = string
    root_volume_type              = string
    asg_max_size                  = string
    asg_desired_capacity          = string
	}))

  default = [{
    name                          = "worker-group-medium"
    instance_type                 = "t3.medium"
    additional_userdata           = ""
    root_volume_type              = "gp2"

    #autoscaling group section
    asg_max_size                  = "3"
    asg_desired_capacity          = "3"
  }]
}

variable "kubernetes_version" {
  type = string
  default = "1.17"
}

variable "access_rules_path" {
  description = "Path to your oathkeeper's access rules definitions YAML file."
  type = string
  default = null
}