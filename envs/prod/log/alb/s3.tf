# /// コストインパクト低のため、削除不要 ///
resource "aws_s3_bucket" "this" {
  bucket        = "laravel-app-dev-${local.name_prefix}-alb-log"
  force_destroy = true #S3バケット内にデータが残っている場合における強制的なバケット削除の有効化

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name = "laravel-app-dev-${local.name_prefix}-alb-log"
  }

  lifecycle_rule {
    enabled = true

    expiration {
      days = "90"
    }
  }
}

# /// コストインパクト低のため、削除不要 ///
resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "arn:aws:iam::${data.aws_elb_service_account.current.id}:root" #「data.tf」で取得している、利用リージョンに応じた「AWSがELBの管理を行っているAWSアカウントID」を指定
          },
          "Action" : "s3:PutObject",
          "Resource" : "arn:aws:s3:::${aws_s3_bucket.this.id}/*"
        },
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "delivery.logs.amazonaws.com"
          },
          "Action" : "s3:PutObject",
          "Resource" : "arn:aws:s3:::${aws_s3_bucket.this.id}/*",
          "Condition" : {
            "StringEquals" : {
              "s3:x-amz-acl" : "bucket-owner-full-control"
            }
          }
        },
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "delivery.logs.amazonaws.com"
          },
          "Action" : "s3:GetBucketAcl",
          "Resource" : "arn:aws:s3:::${aws_s3_bucket.this.id}"
        }
      ]
    }
  )
}
