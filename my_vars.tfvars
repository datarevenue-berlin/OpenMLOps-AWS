tls_certificate_arn = "<copy arn from AWS certificate manager>"

db_username = "eks-mlops"
db_password = "<use a long random string>"

jupyter_dummy_password = "<Use a secure password that your team will share>"

ory_kratos_cookie_secret = "<use a long random string>"
ory_kratos_db_password = "<use a long random string>"

cluster_name = "eks-mlops"
bucket_name = "<use something unique but meaningful>"
hostname = "<use the domain you registered, e.g. example.com>"
protocol = "https"

install_feast = true

additional_aws_users = [
  {
    userarn = "<copy the ARN from AWS IAM>"
    username = "<copy the username from AWS IAM>"
    groups = ["system:masters"]
  },
]

oauth2_providers = [
  {
      provider = "github"
      client_id = "<copy the client id from GitHub>"
      client_secret = "<copy the client secret from GitHub>"
      tenant = ""
    }
]
