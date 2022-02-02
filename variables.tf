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

variable "additional_aws_users" {
  description = "Additional AWS users that will have access to the cluster (e.g. your coworkers)."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)  // e.g. ["system:masters"]
  }))
  default = []
}

variable "eks_worker_groups_az_a" {
  description = "Definition of AWS worker groups to be utilized in availability zone a."
  type = list(object({
    name = string
    instance_type = string
    additional_userdata = string
    root_volume_type              = string
    asg_max_size                  = string
    asg_desired_capacity          = string
	}))

  default = [{
    name                          = "worker-group-medium-a"
    instance_type                 = "t3a.medium"
    additional_userdata           = ""
    root_volume_type              = "gp2"

    #autoscaling group section
    asg_max_size                  = "2"
    asg_desired_capacity          = "1"
  }]
}

variable "eks_worker_groups_az_b" {
  description = "Definition of AWS worker groups to be utilized in availability zone b."
  type = list(object({
    name = string
    instance_type = string
    additional_userdata = string
    root_volume_type              = string
    asg_max_size                  = string
    asg_desired_capacity          = string
	}))

  default = [{
    name                          = "worker-group-medium-b"
    instance_type                 = "t3a.medium"
    additional_userdata           = ""
    root_volume_type              = "gp2"

    #autoscaling group section
    asg_max_size                  = "2"
    asg_desired_capacity          = "1"
  }]
}

variable "kubernetes_version" {
  type = string
  default = "1.18"
}
