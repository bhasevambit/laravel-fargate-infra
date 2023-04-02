data "aws_elb_service_account" "current" {} #利用リージョンに応じた「AWSがELBの管理を行っているAWSアカウントID」を取得 (ALBログのS3書き込み向け情報)
