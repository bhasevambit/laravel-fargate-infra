resource "aws_ecr_repository" "nginx" {
  name = "example-prod-foobar-nginx"

  tags = {
    Name = "example-prod-foobar-nginx"
  }
}

# module "nginx" {
#   source = "../../../../modules/ecr"

#   name = "${local.name_prefix}-${local.service_name}-nginx"
# }

# module "php" {
#   source = "../../../../modules/ecr"

#   name = "${local.name_prefix}-${local.service_name}-php"
# }
