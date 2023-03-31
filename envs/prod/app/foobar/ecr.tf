# /// コストインパクト低のため、削除不要 ///
module "nginx" {
  source = "../../../../modules/ecr"

  name = "example-prod-foobar-nginx"

}

# module "nginx" {
#   source = "../../../../modules/ecr"

#   name = "${local.name_prefix}-${local.service_name}-nginx"
# }

# module "php" {
#   source = "../../../../modules/ecr"

#   name = "${local.name_prefix}-${local.service_name}-php"
# }
