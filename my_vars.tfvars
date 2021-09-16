aws_region = "eu-west-2"
cluster_name = "eks-mlops"
bucket_name = "<use something unique but meaningful>"
additional_aws_users = [
  {
    userarn = "<copy the ARN from AWS IAM>"
    username = "<copy the username from AWS IAM>"
    groups = ["system:masters"]
  },
]
