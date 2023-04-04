data "aws_kms_alias" "rds" {
  name = "alias/aws/rds"
}

data "terraform_remote_state" "network_main" {
  backend = "s3"

  config = {
    bucket = "terraform-backend-353981446712"
    key    = "LaravelApp_Dev_Book_MyCodes_tfstateFile/${local.env_name}/network/main_v1.0.0.tfstate"
    region = "ap-northeast-1"
  }
}
