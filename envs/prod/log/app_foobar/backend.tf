terraform {
  backend "s3" {
    bucket = "terraform-backend-353981446712"
    key    = "LaravelApp_Dev_Book_MyCodes_tfstateFile/prod/log/app_foobar_v1.0.0.tfstate"
    region = "ap-northeast-1"
  }
}
